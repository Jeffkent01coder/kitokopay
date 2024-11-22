import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:kitokopay/service/api_client.dart';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:pointycastle/asymmetric/api.dart' as pointycastle;
import 'package:asn1lib/asn1lib.dart';
import 'package:encrypt/encrypt.dart' as encryptPackage;
import 'package:kitokopay/service/token_storage.dart';
import 'package:kitokopay/service/global_data.dart';
import 'dart:html' as html; // Import html for localStorage
import 'dart:async'; // Import for Timer
// For localStorage
// Import UUID package
// Your API client class import
// Import TokenStorage class
import 'package:kitokopay/models/login_response.dart';

class ElmsSSL {
  static String basic_username = "L@T0wU8eR";
  static String basic_password = "TGF0MHdDb1IzU3Yz";
  String publicKeyString =
      "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0OTq4FBkCO/5kZbBgt+7tHUKmqa6NSvzGnvo8Pia2C7moYDF77TGNcMk5Q5bYjE91QCauAYWxse2thARA1X6FjJz/jeVfYpcV43uuKd8FDaI7P7ah4A+WO4CTwRu95x2a5Hzg0y3qWsxuuBtBeV66uWzKtKcWObPwsblPjfgWkpAxhaIdWhnAk1cXDrukGLrzRIhdY+m3M6yyoW9E+htP9oSkhBF39TxjNtGM0vTSA/w9rVv3x1DGCc7hlvo8DOaj4aG60pdsA7VkVeBnEsXS/lba5dVRFCUHAlMUQfKVx7pZJ9fuHP9IZIfRE0wTPPZwqJSlU8/YQ0ARa5ic5NLjQIDAQAB";

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  Map<String, dynamic> cleanResponse(String jsonResponse) {
    // Parse the main JSON response
    final Map<String, dynamic> parsedResponse = json.decode(jsonResponse);

    // Check if the Data field exists and is a String
    if (parsedResponse.containsKey('Data') &&
        parsedResponse['Data'] is String) {
      // Parse the Data field to remove backslashes
      final Map<String, dynamic> nestedData =
          json.decode(parsedResponse['Data']);
      // Replace the Data field with the cleaned JSON object
      parsedResponse['Data'] = nestedData;
    }

    return parsedResponse;
  }

  Future<String> getCustomer(String mobileNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = const Uuid();
    String Uid = uuid.v4();

    String service = "PROFILE";
    String action = "BASE";
    String command = "GETCUSTOMER";
    String platform = "WEB";
    String CustomerId = "";
    String MobileNumber = mobileNumber;
    String device = "WEB";
    String Lat = "0.200";
    String Lon = "-1.01";

    Map<String, String> F = {
      for (var item in List.generate(41, (index) => index))
        'F${item.toString().padLeft(3, '0')}': ''
    };

    F['F000'] = service;
    F['F001'] = action;
    F['F002'] = command;
    F['F003'] = ""; // AppId
    F['F004'] = CustomerId;
    F['F005'] = MobileNumber;
    F['F009'] = device;
    F['F010'] = device;
    F['F014'] = platform;

    ApiClient apiClient = ApiClient();

    String trxData = jsonEncode(F);

    Map<String, String> appDataMap = {
      "UniqueId": Uid,
      "AppId": "", // AppId
      "device": device,
      "platform": platform,
      "CustomerId": CustomerId,
      "MobileNumber": MobileNumber,
      "Lat": Lat,
      "Lon": Lon,
    };

    String appData = jsonEncode(appDataMap);

    String hashedTrxData = hash(trxData, device);

    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    String Rsc = hashedTrxData;
    String Rrk = encrypt(strKey, publicKeyString);
    String Rrv = encrypt(strIV, publicKeyString);
    String Aad = encrypt1(appData, strKey, strIV);

    String coreData = encrypt1(trxData, strKey, strIV);

    Map<String, String> authRequest = {
      "H00": Uid,
      "H03": Rsc,
      "H01": Rrk,
      "H02": Rrv,
      "H04": Aad,
    };

    Map<String, String> coreRequest = {"Data": coreData};

    final authResultStr = await apiClient.authRequest(authRequest);

    final token = await TokenStorage().getToken();

    final coreResultStr =
        await apiClient.coreRequest(token as String, coreRequest, command);

    // Log coreResult as a string
    print("Core result string: $coreResultStr");

    if (coreResultStr == "Invalid Details!") {
      // Return error json with the message
      return jsonEncode({"status": "error", "message": "Invalid Details!"});
    } else {
      var parsedResponse = cleanResponse(decrypt(coreResultStr, strKey, strIV));
      print("Parsed Response: $parsedResponse");
      print("Customer Id: ${parsedResponse['Data']['CustomerId']}");
      print("App Id: ${parsedResponse['Data']['AppId']}");
      await prefs.setString('customerId', parsedResponse['Data']['CustomerId']);
      await prefs.setString('appId', parsedResponse['Data']['AppId']);
      return jsonEncode({"status": "success"});
    }
  }

  Future<bool> isLocalStorageExpired() async {
    final expiryTimeString = html.window.localStorage['expiryTime'];
    if (expiryTimeString != null) {
      final expiryTime = DateTime.parse(expiryTimeString);
      if (DateTime.now().isAfter(expiryTime)) {
        // Expired, clear the localStorage
        html.window.localStorage.remove('appId');
        html.window.localStorage.remove('customerId');
        html.window.localStorage.remove('expiryTime');
        return true;
      }
    }
    return false;
  }

//   Future<String> activate(
//       String customerId, String appId, String mobileNumber, String otp) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     var uuid = new Uuid();
//     String Uid = uuid.v4();

//     final deviceInfo = DeviceInfoPlugin();
//     String? iMEI;

//     String AppId = appId;
//     String platform = "WEB";

//     if (Platform.isIOS) {
//       IosDeviceInfo? iosInfo = await deviceInfo.iosInfo;
//       iMEI = iosInfo.identifierForVendor; // Use null-aware access
//     } else if (Platform.isAndroid) {
//       AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;
//       iMEI = androidInfo.androidId; // Use null-aware access
//     }

//     String CustomerId =
//         customerId; // returned by GETCUSTOMER call and saved in the app
//     String MobileNumber = mobileNumber; // customer input
//     String device =
//         iMEI ?? ''; // returned by GETCUSTOMER call and saved in the app

//     String Lat = "0.200";
//     String Lon = "-1.01";

//     ApiClient apiClient = ApiClient();

//     String strKey = apiClient.generateRandomString(16);
//     String strIV = apiClient.generateRandomString(16);

//     Map<String, String> fValues = {
//       "F000": "PROFILE",
//       "F001": "BASE",
//       "F002": "ACTIVATE",
//       "F003": AppId,
//       "F004": CustomerId,
//       "F005": MobileNumber,
//       "F006": "",
//       "F007": "",
//       "F008": "PIN",
//       "F009": "WEB", // IMEI
//       "F010": "WEB",
//       "F013": otp, // OTP activation code received via email
//       "F014": platform,
//     };

//     for (int i = 11; i <= 40; i++) {
//       if (!fValues.containsKey("F${i.toString().padLeft(3, '0')}")) {
//         fValues["F${i.toString().padLeft(3, '0')}"] = "";
//       }
//     }

//     String trxData = jsonEncode(fValues);

//     String appData = jsonEncode({
//       "UniqueId": Uid,
//       "AppId": AppId,
//       "device": device,
//       "platform": platform,
//       "CustomerId": CustomerId,
//       "MobileNumber": MobileNumber,
//       "Lat": Lat,
//       "Lon": Lon,
//     });

//     print(trxData);
//     String hashedTrxData = hash(trxData, device);
//     print("");
//     print(hashedTrxData);
//     print("");

//     String Rsc = hashedTrxData;
//     String Rrk = encrypt(strKey, publicKeyString);
//     String Rrv = encrypt(strIV, publicKeyString);
//     String Aad = encrypt1(appData, strKey, strIV);

//     String coreData = encrypt1(trxData, strKey, strIV);

//     Map<String, String> authRequest = {
//       "H00": Uid,
//       "H03": Rsc,
//       "H01": Rrk,
//       "H02": Rrv,
//       "H04": Aad,
//     };

//     Map<String, String> coreRequest = {"Data": coreData};

//     final authResultStr = await apiClient.authRequest(authRequest);

//     final token = TokenStorage().getToken();

//     final coreResultStr =
//         await apiClient.coreRequest(token, coreRequest, "ACTIVATE");

//     // final String coreDecryted =
//     //     decrypt(GlobalData().getCoreDataResult(), strKey, strIV);

//     // Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

//     // print("Activate Decrypted response: $responseBody");

//     if (GlobalData().getIs401ActivationResponse() == 401 && otp != "") {
//       final String coreDecryted =
//           decrypt(GlobalData().getActivateCoreDataResult(), strKey, strIV);

//       Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

//       if (responseBody.isNotEmpty) {
//         ActivationResponse activationResponse =
//             ActivationResponse.fromJson(responseBody);

//         prefs.setString("deviceId", activationResponse.data.deviceId ?? "");

//         GlobalData().setDeviceId(activationResponse.data.deviceId ?? "");
//       }
//     }

//     return "";
//   }

  Future<String> login(String pin, String mobileNumber) async {
    var uuid = const Uuid();
    String Uid = uuid.v4();

    print("UUID: $Uid");
    print("Pin: $pin");
    print("Mobile Number: $mobileNumber");
    print("Public Key: $publicKeyString");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiClient apiClient = ApiClient();

    // Get AppId and CustomerId from SharedPreferences
    String? AppId = prefs.getString("appId");
    String? CustomerId = prefs.getString("customerId");

    // Check if AppId or CustomerId is empty; if so, fetch using getCustomer
    if (AppId == null ||
        AppId.isEmpty ||
        CustomerId == null ||
        CustomerId.isEmpty) {
      final result = await getCustomer(mobileNumber);
      Map<String, dynamic> resultMap = jsonDecode(result);

      if (resultMap['status'] == 'success') {
        // Refetch AppId and CustomerId after a successful getCustomer call
        AppId = prefs.getString("appId");
        CustomerId = prefs.getString("customerId");

        if (AppId == null ||
            AppId.isEmpty ||
            CustomerId == null ||
            CustomerId.isEmpty) {
          return 'Error fetching AppId or CustomerId';
        }
      } else {
        // Handle error message from response
        String errorMessage = resultMap['message'] ?? 'Invalid details!';
        return errorMessage;
      }
    }

    print(
        "AppId: $AppId, CustomerId: $CustomerId, Mobile Number: $mobileNumber, Pin: $pin");

    String platform = "WEB";
    String device = "WEB";
    String Lat = "0.200";
    String Lon = "-1.01";

    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    Map<String, String> fValues = {
      "F000": "PROFILE",
      "F001": "BASE",
      "F002": "LOGIN",
      "F003": AppId,
      "F004": CustomerId,
      "F005": mobileNumber,
      "F006": "",
      "F007": encrypt(pin, publicKeyString),
      "F008": pin,
      "F009": device,
      "F010": device,
      "F014": platform,
    };

    String trxData = jsonEncode(fValues);
    print("Trx Data: $trxData");

    String appData = jsonEncode({
      "UniqueId": Uid,
      "AppId": AppId,
      "device": device,
      "platform": platform,
      "CustomerId": CustomerId,
      "MobileNumber": mobileNumber,
      "Lat": Lat,
      "Lon": Lon,
    });

    String hashedTrxData = hash(trxData, device);
    String Rsc = hashedTrxData;
    String Rrk = encrypt(strKey, publicKeyString);
    String Rrv = encrypt(strIV, publicKeyString);
    String Aad = encrypt1(appData, strKey, strIV);

    String coreData = encrypt1(trxData, strKey, strIV);

    Map<String, String> coreRequest = {"Data": coreData};
    Map<String, String> authRequest = {
      "H00": Uid,
      "H03": Rsc,
      "H01": Rrk,
      "H02": Rrv,
      "H04": Aad,
    };

    // Send authentication request
    final authResultStr = await apiClient.authRequest(authRequest);
    final token = await TokenStorage().getToken();

    print("Token: $token");
    print("Core Request: $coreRequest");

    final coreResultStr =
        await apiClient.coreRequest(token as String, coreRequest, "LOGIN");

    if (coreResultStr == "Invalid Details!") {
      // Return error json with the message
      return jsonEncode({"status": "error", "message": "Invalid Details!"});
    } else {
      var parsedResponse = cleanResponse(decrypt(coreResultStr, strKey, strIV));
      print("Parsed Response: $parsedResponse");

      // Store the parsed response in preferences
      await prefs.setString('loginDetails', jsonEncode(parsedResponse));

      final loadDetailsResponse = await loanDetails();

      return loadDetailsResponse;
    }
  }

  Future<String> applyLoan(String appliedAmount, String pin) async {
    var uuid = Uuid();
    var Uid = uuid.v4();

    SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiClient apiClient = ApiClient();

    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    var serviceDetails = {
      "service": "LOAN",
      "action": "BASE",
      "command": "APPLICATION",
    };

    String? AppId = prefs.getString("appId");
    String? CustomerId = prefs.getString("customerId");

    // Retrieve login details to get mobileNumber
    String mobileNumber = '';
    String currency = "";
    String limitAmount = "";
    String? loginResponseStr = prefs.getString('loginDetails');

    if (loginResponseStr != null) {
      // Parse the login response to extract mobileNumber
      final loginResponse = jsonDecode(loginResponseStr);
      mobileNumber = loginResponse['Data']['MobileNumber'] ?? '';
      currency = loginResponse['Data']['Currency'] ?? '';
      limitAmount = loginResponse['Data']['LimitAmount'] ?? '';
    }

    print(
        "AppId: $AppId, CustomerId: $CustomerId, MobileNumber: $mobileNumber, Currency: $currency, LimitAmount: $limitAmount");

    var appDetails = {
      "AppId": AppId,
      "platform": "WEB",
      "CustomerId": CustomerId,
      "MobileNumber": mobileNumber, // saved
      "device": "WEB", // saved or read
      "Lat": "0.200",
      "Lon": "-1.01",
    };

    var transactionDetails = {
      "F000": serviceDetails["service"],
      "F001": serviceDetails["action"],
      "F002": serviceDetails["command"],
      "F003": AppId,
      "F004": CustomerId,
      "F005": appDetails["MobileNumber"],
      "F006": "",
      "F007": encrypt(pin, publicKeyString), // request customer to enter PIN
      "F008": "PIN",
      "F009": "WEB", // IMEI
      "F010": "WEB",
      "F011": "YES", // PIN required, YES
      "F012": "",
      "F013": "",
      "F014": "WEB",
      "F015": "",
      "F016": "",
      "F017": "",
      "F018": "",
      "F019": "",
      "F020": currency,
      "F021": mobileNumber, // MobileNumber
      "F022": "", // NationalId
      "F023": appliedAmount, // AppliedAmount
      "F024": limitAmount, // LimitAmount
      "F025": apiClient.generateRandomString(16), // Dummy Reference
      "F026": "",
      "F027": "", // DOB
      "F028": "", // Email Address
      "F029": "",
      "F030": "",
    };

    var trxData = jsonEncode(transactionDetails);
    var appData = jsonEncode(appDetails);

    var hashedTrxData = hash(trxData, appDetails["device"]!);

    print(trxData);
    print("");
    print(hashedTrxData);
    print("");

    var Rsc = hashedTrxData;
    var Rrk = encrypt(strKey, publicKeyString);
    var Rrv = encrypt(strIV, publicKeyString);
    var Aad = encrypt1(appData, strKey, strIV);

    var coreData = encrypt1(trxData, strKey, strIV);

    Map<String, String> authRequest = {
      "H00": "$Uid",
      "H03": "$Rsc",
      "H01": "$Rrk",
      "H02": "$Rrv",
      "H04": "$Aad"
    };

    Map<String, String> coreRequest = {"Data": coreData};

    final authResultStr = await apiClient.authRequest(authRequest);

    final token = await TokenStorage().getToken();

    print("Retrieved token: $token");

    final coreResultStr = await apiClient.coreRequest(
        token as String, coreRequest, "APPLICATION");

    print("Apply Loan response: $coreResultStr");

    if (coreResultStr == "Invalid Details!") {
      // Return error json with the message
      return jsonEncode({"status": "error", "message": "Invalid Details!"});
    } else {
      var parsedResponse = cleanResponse(decrypt(coreResultStr, strKey, strIV));
      print("Parsed Response: $parsedResponse");

      // Store the parsed response in preferences
      await prefs.setString('applyLoanDetails', jsonEncode(parsedResponse));

      return jsonEncode(
          {"status": "success", "message": "Loan applied successfully"});
    }

    return "";
  }

  Future<String> loanDetails() async {
    var uuid = const Uuid();
    String uid = uuid.v4();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    ApiClient apiClient = ApiClient();

    String service = "LOAN";
    String action = "BASE";
    String command = "DETAILS";
    String platform = "WEB";

    // Retrieve appId and customerId from SharedPreferences
    String appId = prefs.getString("appId") ?? '';
    String customerId = prefs.getString("customerId") ?? '';

    // Retrieve login details to get mobileNumber
    String mobileNumber = '';
    String? loginResponseStr = prefs.getString('loginDetails');

    if (loginResponseStr != null) {
      // Parse the login response to extract mobileNumber
      final loginResponse = jsonDecode(loginResponseStr);
      mobileNumber = loginResponse['Data']['MobileNumber'] ?? '';
    }

    print(
        "AppId: $appId, CustomerId: $customerId, MobileNumber: $mobileNumber");

    String device = "WEB";
    String lat = "0.200";
    String lon = "-1.01";

    // Prepare transaction data (trxData) fields
    Map<String, String> trxDataMap = {
      "F000": service,
      "F001": action,
      "F002": command,
      "F003": appId,
      "F004": customerId,
      "F005": mobileNumber,
      "F009": device,
      "F010": device,
      "F014": platform,
      "F021": mobileNumber,
      "F022": GlobalData().getLoginLoanId(),
    };

    String trxData = jsonEncode(trxDataMap);

    String appData = jsonEncode({
      "UniqueId": uid,
      "AppId": appId,
      "Device": device,
      "Platform": platform,
      "CustomerId": customerId,
      "MobileNumber": mobileNumber,
      "Lat": lat,
      "Lon": lon,
    });

    String hashedTrxData = hash(trxData, device);
    print("Transaction Data: $trxData");
    print("Hashed Trx Data: $hashedTrxData");

    // Encryption setup
    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    String rsc = hashedTrxData;
    String rrk = encrypt(strKey, publicKeyString);
    String rrv = encrypt(strIV, publicKeyString);
    String aad = encrypt1(appData, strKey, strIV);

    String coreData = encrypt1(trxData, strKey, strIV);

    Map<String, String> authRequest = {
      "H00": uid,
      "H03": rsc,
      "H01": rrk,
      "H02": rrv,
      "H04": aad,
    };

    Map<String, String> coreRequest = {"Data": coreData};

    // Perform authentication request
    await apiClient.authRequest(authRequest);

    // Get the token and perform core request
    final token = await TokenStorage().getToken();
    final coreResultStr =
        await apiClient.coreRequest(token as String, coreRequest, "DETAILS");

    // Decrypt and parse the core result
    String coreDecrypted = decrypt(coreResultStr, strKey, strIV);
    print("Decrypted Core Result: $coreDecrypted");

    if (coreResultStr == "Invalid Details!") {
      return jsonEncode(
          {"status": "error", "message": "Error fetching loan details!"});
    } else {
      var parsedResponse = cleanResponse(coreDecrypted);
      print("Parsed loan details Response: $parsedResponse");

      // Store the parsed response in preferences
      await prefs.setString('loanDetails', jsonEncode(parsedResponse));
      return jsonEncode({"status": "success"});
    }
  }

//   Future<String> reActivate(String otp) async {
//     var uuid = Uuid();
//     String uid = uuid.v4();

//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     publicKeyString = publicKeyString != ""
//         ? publicKeyString
//         : prefs.getString('publicKey') ?? '';

//     ApiClient apiClient = ApiClient();

//     final deviceInfo = DeviceInfoPlugin();
//     String? iMEI;

//     if (Platform.isIOS) {
//       IosDeviceInfo? iosInfo = await deviceInfo.iosInfo;
//       iMEI = iosInfo.identifierForVendor; // Use null-aware access
//     } else if (Platform.isAndroid) {
//       AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;
//       iMEI = androidInfo.androidId; // Use null-aware access
//     }

//     String service = "PROFILE";
//     String action = "BASE";
//     String command = "REACTIVATE";

//     String appId = GlobalData().getAppId() != ''
//         ? GlobalData().getAppId()
//         : prefs.getString("appId") ??
//             ''; // returned by GETCUSTOMER call and saved in the app
//     String platform = Platform.isIOS ? "ios" : "android";

//     String customerId = GlobalData().getCustomerId() != ''
//         ? GlobalData().getCustomerId()
//         : prefs.getString("customerId") ?? ''; // stored
//     String mobileNumber = GlobalData().getMobileNumber() != ''
//         ? GlobalData().getMobileNumber()
//         : prefs.getString("mobileNumber") ?? ''; // stored
//     String device = iMEI ?? ""; // stored or read

//     String lat = "0.200";
//     String lon = "-1.01";

//     String rsc; // Rsa Somme de Control
//     String rrk; // Rsa Random Key
//     String rrv; // Rsa Random Vector
//     String aad; // Aes App Data

//     String f000 = service;
//     String f001 = action;
//     String f002 = command;
//     String f003 = appId;
//     String f004 = customerId;
//     String f005 = mobileNumber;
//     String f006 = "";
//     String f007 = "";
//     String f008 = "";
//     String f009 = device; // IMEI
//     String f010 = device;
//     String f011 = "";
//     String f012 = "";
//     String f013 = otp;
//     String f014 = platform;
//     String f015 = "";
//     String f016 = "";
//     String f017 = "";
//     String f018 = "";
//     String f019 = "";
//     String f020 = "";
//     String f021 = "";
//     String f022 = "";
//     String f023 = "";
//     String f024 = "";
//     String f025 = "";
//     String f026 = "";
//     String f027 = "";
//     String f028 = "";
//     String f029 = "";
//     String f030 = "";
//     String f031 = "";
//     String f032 = "";
//     String f033 = "";
//     String f034 = "";
//     String f035 = "";
//     String f036 = "";
//     String f037 = "";
//     String f038 = "";
//     String f039 = "";
//     String f040 = "";

//     String trxData = jsonEncode({
//       'F000': f000,
//       'F001': f001,
//       'F002': f002,
//       'F003': f003,
//       'F004': f004,
//       'F005': f005,
//       'F006': f006,
//       'F007': f007,
//       'F008': f008,
//       'F009': f009,
//       'F010': f010,
//       'F011': f011,
//       'F012': f012,
//       'F013': f013,
//       'F014': f014,
//       'F015': f015,
//       'F016': f016,
//       'F017': f017,
//       'F018': f018,
//       'F019': f019,
//       'F020': f020,
//       'F021': f021,
//       'F022': f022,
//       'F023': f023,
//       'F024': f024,
//       'F025': f025,
//       'F026': f026,
//       'F027': f027,
//       'F028': f028,
//       'F029': f029,
//       'F030': f030,
//       'F031': f031,
//       'F032': f032,
//       'F033': f033,
//       'F034': f034,
//       'F035': f035,
//       'F036': f036,
//       'F037': f037,
//       'F038': f038,
//       'F039': f039,
//       'F040': f040,
//     });

//     String appData = jsonEncode({
//       'UniqueId': uid,
//       'AppId': appId,
//       'Device': device,
//       'Platform': platform,
//       'CustomerId': customerId,
//       'MobileNumber': mobileNumber,
//       'Lat': lat,
//       'Lon': lon,
//     });

//     print(trxData);
//     String hashedTrxData = hash(trxData, device);
//     print(hashedTrxData);

//     String strKey = "lbXDF0000yxrG24B";
//     String strIV = "HlPGoH11117Pf5sv";

//     rsc = hashedTrxData;
//     rrk = encrypt(strKey, publicKeyString);
//     rrv = encrypt(strIV, publicKeyString);
//     aad = encrypt1(appData, strKey, strIV);

//     String coreData = encrypt1(trxData, strKey, strIV);

//     Map<String, String> authRequest = {
//       'H00': uid,
//       'H03': rsc,
//       'H01': rrk,
//       'H02': rrv,
//       'H04': aad,
//     };

//     Map<String, String> coreRequest = {'Data': coreData};

//     final authResultStr = await apiClient.authRequest(authRequest);

//     final token = TokenStorage().getToken();

//     final coreResultStr =
//         await apiClient.coreRequest(token, coreRequest, "REACTIVATE");

//     if (GlobalData().getIs401ReactivateResponse() == 401 && otp != "") {
//       print("First check" + GlobalData().getReactivateCoreDataResult());
//       final String coreDecryted =
//           decrypt(GlobalData().getReactivateCoreDataResult(), strKey, strIV);

//       print("Secondddddd check" + coreDecryted);

//       Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

//       if (responseBody.isNotEmpty) {
//         ActivationResponse activationResponse =
//             ActivationResponse.fromJson(responseBody);

//         GlobalData().setDeviceId(activationResponse.data.deviceId ?? "");
//       }
//     }

//     // final String coreDecryted =
//     //     decrypt(GlobalData().getCoreDataResult(), strKey, strIV);

//     // Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

//     // print("Activate Decrypted response: $responseBody");

//     return "";
//   }

//   Future<String> resetPin() async {
//     var uuid = Uuid();
//     String uid = uuid.v4();

//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     publicKeyString = publicKeyString != ""
//         ? publicKeyString
//         : prefs.getString('publicKey') ?? '';

//     ApiClient apiClient = ApiClient();

//     final deviceInfo = DeviceInfoPlugin();
//     String? iMEI;

//     if (GlobalData().getDeviceId() != "" ||
//         prefs.getString("deviceId") != null ||
//         prefs.getString("deviceId") != "") {
//       iMEI = prefs.getString("deviceId") ?? GlobalData().getDeviceId();
//     } else {
//       if (Platform.isIOS) {
//         IosDeviceInfo? iosInfo = await deviceInfo.iosInfo;
//         iMEI = iosInfo.identifierForVendor; // Use null-aware access
//       } else if (Platform.isAndroid) {
//         AndroidDeviceInfo? androidInfo = await deviceInfo.androidInfo;
//         iMEI = androidInfo.androidId; // Use null-aware access
//       }
//     }

//     String service = "PROFILE";
//     String action = "BASE";
//     String command = "RESETPIN";

//     String appId = GlobalData().getAppId() != ''
//         ? GlobalData().getAppId()
//         : prefs.getString("appId") ??
//             ''; // returned by GETCUSTOMER call and saved in the app
//     String platform = Platform.isIOS ? "ios" : "android";

//     String customerId = GlobalData().getCustomerId() != ''
//         ? GlobalData().getCustomerId()
//         : prefs.getString("customerId") ?? ''; // stored
//     String mobileNumber = GlobalData().getMobileNumber() != ''
//         ? GlobalData().getMobileNumber()
//         : prefs.getString("mobileNumber") ?? ''; // stored
//     String device = iMEI ?? ""; // stored or read

//     String lat = "0.200";
//     String lon = "-1.01";

//     String rsc; // Rsa Somme de Control
//     String rrk; // Rsa Random Key
//     String rrv; // Rsa Random Vector
//     String aad; // Aes App Data

//     String f000 = service;
//     String f001 = action;
//     String f002 = command;
//     String f003 = appId;
//     String f004 = customerId;
//     String f005 = mobileNumber;
//     String f006 = "";
//     String f007 = "";
//     String f008 = "";
//     String f009 = device; // IMEI
//     String f010 = device;
//     String f011 = "";
//     String f012 = "";
//     String f013 = "";
//     String f014 = platform;
//     String f015 = "";
//     String f016 = "";
//     String f017 = "";
//     String f018 = "";
//     String f019 = "";
//     String f020 = "";
//     String f021 = "";
//     String f022 = "";
//     String f023 = "";
//     String f024 = "";
//     String f025 = "";
//     String f026 = "";
//     String f027 = "";
//     String f028 = "";
//     String f029 = "";
//     String f030 = "";
//     String f031 = "";
//     String f032 = "";
//     String f033 = "";
//     String f034 = "";
//     String f035 = "";
//     String f036 = "";
//     String f037 = "";
//     String f038 = "";
//     String f039 = "";
//     String f040 = "";

//     String trxData = jsonEncode({
//       'F000': f000,
//       'F001': f001,
//       'F002': f002,
//       'F003': f003,
//       'F004': f004,
//       'F005': f005,
//       'F006': f006,
//       'F007': f007,
//       'F008': f008,
//       'F009': f009,
//       'F010': f010,
//       'F011': f011,
//       'F012': f012,
//       'F013': f013,
//       'F014': f014,
//       'F015': f015,
//       'F016': f016,
//       'F017': f017,
//       'F018': f018,
//       'F019': f019,
//       'F020': f020,
//       'F021': f021,
//       'F022': f022,
//       'F023': f023,
//       'F024': f024,
//       'F025': f025,
//       'F026': f026,
//       'F027': f027,
//       'F028': f028,
//       'F029': f029,
//       'F030': f030,
//       'F031': f031,
//       'F032': f032,
//       'F033': f033,
//       'F034': f034,
//       'F035': f035,
//       'F036': f036,
//       'F037': f037,
//       'F038': f038,
//       'F039': f039,
//       'F040': f040,
//     });

//     String appData = jsonEncode({
//       'UniqueId': uid,
//       'AppId': appId,
//       'Device': device,
//       'Platform': platform,
//       'CustomerId': customerId,
//       'MobileNumber': mobileNumber,
//       'Lat': lat,
//       'Lon': lon,
//     });

//     print(trxData);
//     String hashedTrxData = hash(trxData, device);
//     print(hashedTrxData);

//     String strKey = "lbXDF0000yxrG24B";
//     String strIV = "HlPGoH11117Pf5sv";

//     rsc = hashedTrxData;
//     rrk = encrypt(strKey, publicKeyString);
//     rrv = encrypt(strIV, publicKeyString);
//     aad = encrypt1(appData, strKey, strIV);

//     String coreData = encrypt1(trxData, strKey, strIV);

//     Map<String, String> authRequest = {
//       'H00': uid,
//       'H03': rsc,
//       'H01': rrk,
//       'H02': rrv,
//       'H04': aad,
//     };

//     Map<String, String> coreRequest = {'Data': coreData};

//     final authResultStr = await apiClient.authRequest(authRequest);

//     final token = TokenStorage().getToken();

//     final coreResultStr =
//         await apiClient.coreRequest(token, coreRequest, "RESETPIN");

//     // final String coreDecryted =
//     //     decrypt(GlobalData().getCoreDataResult(), strKey, strIV);

//     // Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

//     // print("Activate Decrypted response: $responseBody");

//     return "";
//   }

  String encrypt(String textToEncrypt, String publicKeyString) {
    try {
      final publicKey = getPublicKeyFromString(publicKeyString);
      final encryptedData = encryptData(textToEncrypt, publicKey);
      return base64.encode(encryptedData);
    } on Exception catch (ex) {
      print(ex.toString());
      return "Encryption failed due to: ${ex.toString()}";
    }
  }

  Uint8List encryptData(String data, pointycastle.RSAPublicKey publicKey) {
    try {
      final cipher = PKCS1Encoding(RSAEngine())
        ..init(true, PublicKeyParameter<pointycastle.RSAPublicKey>(publicKey));
      final plaintextBytes = Uint8List.fromList(data.codeUnits);
      return cipher.process(plaintextBytes);
    } on Exception catch (ex) {
      print('Encryption failed due to: ${ex.toString()}');
      return Uint8List(0);
    }
  }

  RSAPublicKey getPublicKeyFromString(String publicKeyString) {
    try {
      final bytes = base64Decode(publicKeyString);
      final asn1Parser = ASN1Parser(bytes);
      final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;

      if (topLevelSeq.elements.length != 2) {
        throw Exception(
            "Invalid public key string: less than two elements in ASN1 sequence");
      }

      final bitString = topLevelSeq.elements[1] as ASN1BitString;
      final publicKeyBytes = bitString
          .valueBytes()
          .sublist(1); // Skip the first byte (unused bits)
      final publicKeyAsn = ASN1Parser(publicKeyBytes);
      final publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;

      if (publicKeySeq.elements.length != 2) {
        throw Exception(
            "Invalid public key data: less than two elements in ASN1 sequence");
      }

      final modulus = publicKeySeq.elements[0] as ASN1Integer;
      final exponent = publicKeySeq.elements[1] as ASN1Integer;

      return RSAPublicKey(
          modulus.valueAsBigInteger, exponent.valueAsBigInteger);
    } catch (ex, stackTrace) {
      print('Exception: $ex\nStack trace: $stackTrace');
      throw Exception("Failed to parse public key: ${ex.toString()}");
    }
  }

  // END RSA

  // START AES

  String encrypt1(String data, String keyStr, String ivStr) {
    try {
      final key = encryptPackage.Key.fromUtf8(keyStr);
      final iv = encryptPackage.IV.fromUtf8(ivStr);
      final encrypter = encryptPackage.Encrypter(
          encryptPackage.AES(key, mode: encryptPackage.AESMode.gcm));
      final encrypted = encrypter.encrypt(data, iv: iv);
      return encrypted.base64;
    } catch (ex) {
      throw Exception("Failed to encrypt data: ${ex.toString()}");
    }
  }

  String decrypt(String data, String keyStr, String ivStr) {
    try {
      final key = encryptPackage.Key.fromUtf8(keyStr);
      final iv = encryptPackage.IV.fromUtf8(ivStr);
      final encrypter = encryptPackage.Encrypter(
          encryptPackage.AES(key, mode: encryptPackage.AESMode.gcm));
      final decrypted = encrypter.decrypt64(data, iv: iv);
      return decrypted;
    } catch (ex) {
      throw Exception("Failed to decrypt: ${ex.toString()}");
    }
  }

  String hash(String data, String salt) {
    final originalString = '$data$salt';
    final bytes = utf8.encode(originalString);
    final digest = sha256.convert(bytes);
    return bytesToHex(digest.bytes);
  }

  String bytesToHex(List<int> bytes) {
    final hexString = StringBuffer();
    for (var byte in bytes) {
      var hex = byte.toRadixString(16);
      if (hex.length == 1) {
        hexString.write('0');
      }
      hexString.write(hex);
    }
    return hexString.toString();
  }

  String encode(String value) {
    final encodedBytes = base64.encode(utf8.encode(value));
    return utf8.decode(encodedBytes.codeUnits);
  }
}
