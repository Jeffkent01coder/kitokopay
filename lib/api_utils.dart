import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:testlogin/api_client.dart';
import 'dart:typed_data';
import 'package:pointycastle/export.dart';
import 'package:uuid/uuid.dart';
import 'package:pointycastle/asymmetric/api.dart' as pointycastle;
import 'package:asn1lib/asn1lib.dart';
import 'package:encrypt/encrypt.dart' as encryptPackage;

class ElmsSSL {
  static String basic_username = "L@T0wU8eR";
  static String basic_password = "TGF0MHdDb1IzU3Yz";
  String publicKeyString =
      "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0OTq4FBkCO/5kZbBgt+7tHUKmqa6NSvzGnvo8Pia2C7moYDF77TGNcMk5Q5bYjE91QCauAYWxse2thARA1X6FjJz/jeVfYpcV43uuKd8FDaI7P7ah4A+WO4CTwRu95x2a5Hzg0y3qWsxuuBtBeV66uWzKtKcWObPwsblPjfgWkpAxhaIdWhnAk1cXDrukGLrzRIhdY+m3M6yyoW9E+htP9oSkhBF39TxjNtGM0vTSA/w9rVv3x1DGCc7hlvo8DOaj4aG60pdsA7VkVeBnEsXS/lba5dVRFCUHAlMUQfKVx7pZJ9fuHP9IZIfRE0wTPPZwqJSlU8/YQ0ARa5ic5NLjQIDAQAB";

  void printLongString(String text) {
    final RegExp pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => debugPrint(match.group(0)));
  }

  Future<String> getCustomer(String mobileNumber) async {
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    var uuid = const Uuid();
    String Uid = uuid.v4();

    print('Public Key: $publicKeyString');

    String service = "PROFILE";
    String action = "BASE";
    String command = "GETCUSTOMER";
    String AppId = "";
    String platform = "android";
    String CustomerId = "";
    String MobileNumber = mobileNumber;
    String device = "android";
    String Lat = "0.200";
    String Lon = "-1.01";
    print('Here is the code');
    Map<String, String> F = { for (var item in List.generate(41, (index) => index)) 'F${item.toString().padLeft(3, '0')}' : '' };
    print('Here is the code');
    F['F000'] = service;
    F['F001'] = action;
    F['F002'] = command;
    F['F003'] = AppId;
    F['F004'] = CustomerId;
    F['F005'] = MobileNumber;
    F['F009'] = device;
    F['F010'] = device;
    F['F014'] = platform;

    ApiClient apiClient = ApiClient();

    String trxData = jsonEncode(F);

    Map<String, String> appDataMap = {
      "UniqueId": Uid,
      "AppId": AppId,
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

    print("TokenResults : $authResultStr");

    final token = authResultStr;

    print("----------- coreData ------------");
    print(coreData);

    final coreResultStr =
        await apiClient.coreRequest(token, coreRequest, command);

    final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

    Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

    print("Decrypted response: $responseBody");

    if (responseBody.isNotEmpty &&
        jsonDecode(responseBody['Data'])['Status'].isNotEmpty) {}
    return "";
  }

  Future<String> activate(
      String customerId, String appId, String mobileNumber, String otp) async {
    var uuid = const Uuid();
    String Uid = uuid.v4();

    // final deviceInfo = DeviceInfoPlugin();
    String? iMEI;

    String AppId = appId;
    String platform = "android";

    String CustomerId =
        customerId; // returned by GETCUSTOMER call and saved in the app
    String MobileNumber = mobileNumber; // customer input
    String device =
        iMEI ?? ''; // returned by GETCUSTOMER call and saved in the app

    String Lat = "0.200";
    String Lon = "-1.01";

    ApiClient apiClient = ApiClient();

    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    Map<String, String> fValues = {
      "F000": "PROFILE",
      "F001": "BASE",
      "F002": "ACTIVATE",
      "F003": AppId,
      "F004": CustomerId,
      "F005": MobileNumber,
      "F006": "",
      "F007": "",
      "F008": "PIN",
      "F009": device, // IMEI
      "F010": device,
      "F013": otp, // OTP activation code received via email
      "F014": platform,
    };

    for (int i = 11; i <= 40; i++) {
      if (!fValues.containsKey("F${i.toString().padLeft(3, '0')}")) {
        fValues["F${i.toString().padLeft(3, '0')}"] = "";
      }
    }

    String trxData = jsonEncode(fValues);

    String appData = jsonEncode({
      "UniqueId": Uid,
      "AppId": AppId,
      "device": device,
      "platform": platform,
      "CustomerId": CustomerId,
      "MobileNumber": MobileNumber,
      "Lat": Lat,
      "Lon": Lon,
    });

    print(trxData);
    String hashedTrxData = hash(trxData, device);
    print("");
    print(hashedTrxData);
    print("");

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

    final token = authResultStr;

    final coreResultStr =
        await apiClient.coreRequest(token, coreRequest, "ACTIVATE");

    final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

    Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

    if (responseBody.isNotEmpty) {}

    return "";
  }

  Future<String> login(String appId, String iMEI, String pin, String customerId,
      String mobileNumber) async {
    var uuid = const Uuid();
    String Uid = uuid.v4();

    //SharedPreferences prefs = await SharedPreferences.getInstance();

    ApiClient apiClient = ApiClient();

    // returned by GETCUSTOMER call and saved in the app
    String platform = "android";

    String device = iMEI ?? '';

    String CustomerId =
        customerId; // returned by GETCUSTOMER call and saved in the app
    String MobileNumber = mobileNumber; // customer input
    // returned by GETCUSTOMER call and saved in the app

    String Lat = "0.200";
    String Lon = "-1.01";

    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    Map<String, String> fValues = {
      "F000": "PROFILE",
      "F001": "BASE",
      "F002": "LOGIN",
      "F003": appId,
      "F004": customerId,
      "F005": mobileNumber,
      "F006": "",
      "F007": encrypt(
          pin, publicKeyString), // PIN received via email or sms, eg: 1234
      "F008": pin,
      "F009": device, // IMEI
      "F010": device,
      "F014": platform,
    };

    String trxData = jsonEncode(fValues);

    String appData = jsonEncode({
      "UniqueId": Uid,
      "AppId": appId,
      "device": device,
      "platform": platform,
      "CustomerId": CustomerId,
      "MobileNumber": MobileNumber,
      "Lat": Lat,
      "Lon": Lon,
    });

    print(appData);
    print(trxData);
    String hashedTrxData = hash(trxData, device);
    print("");
    print(hashedTrxData);
    print("");

    String Rsc = hashedTrxData;
    String Rrk = encrypt(strKey, publicKeyString);
    String Rrv = encrypt(strIV, publicKeyString);
    String Aad = encrypt1(appData, strKey, strIV);

    String coreData = encrypt1(trxData, strKey, strIV);

    Map<String, String> coreRequest = {"Data": coreData};

    Map<String, dynamic> authRequest = {
      "H00": Uid,
      "H03": Rsc,
      "H01": Rrk,
      "H02": Rrv,
      "H04": Aad,
    };

    final authResultStr = await apiClient.authRequest(authRequest);

    final token = authResultStr;

    final coreResultStr =
        await apiClient.coreRequest(token, coreRequest, "LOGIN");

    final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

    Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

    try {
      if (responseBody.isNotEmpty) {
        if (jsonDecode(responseBody['Data'])['Loans'] == "") {
        } else {}
      }
    } catch (e) {
      print(e);
    }

    print("Decrypted Login response: $responseBody");

    return "";
  }

  Future<String> biometric(
      String iMEI, String appId, String customerId, String mobileNumber) async {
    var uuid = const Uuid();
    String Uid = uuid.v4();

    ApiClient apiClient = ApiClient();

    String AppId = appId;
    // returned by GETCUSTOMER call and saved in the app
    String platform = "android";

    String? iMEI;

    String device = iMEI ?? '';

    String CustomerId =
        customerId; // returned by GETCUSTOMER call and saved in the app
    String MobileNumber = mobileNumber; // customer input
    // returned by GETCUSTOMER call and saved in the app

    String Lat = "0.200";
    String Lon = "-1.01";

    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    Map<String, String> fValues = {
      "F000": "PROFILE",
      "F001": "BASE",
      "F002": "BIOMETRIC",
      "F003": AppId,
      "F004": CustomerId,
      "F005": MobileNumber,
      "F006": "",
      "F007": encrypt(
          '', publicKeyString), // PIN received via email or sms, eg: 1234
      "F008": '',
      "F009": device, // IMEI
      "F010": device,
      "F014": platform,
    };

    String trxData = jsonEncode(fValues);

    String appData = jsonEncode({
      "UniqueId": Uid,
      "AppId": AppId,
      "device": device,
      "platform": platform,
      "CustomerId": CustomerId,
      "MobileNumber": MobileNumber,
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

    Map<String, dynamic> authRequest = {
      "H00": Uid,
      "H03": Rsc,
      "H01": Rrk,
      "H02": Rrv,
      "H04": Aad,
    };

    final authResultStr = await apiClient.authRequest(authRequest);

    final token = authResultStr;

    final coreResultStr =
        await apiClient.coreRequest(token, coreRequest, "LOGIN");

    final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

    Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

    try {
      if (responseBody.isNotEmpty) {
        if (jsonDecode(responseBody['Data'])['Loans'] == "") {
        } else {}
      }
    } catch (e) {
      print(e);
    }

    print("Decrypted Biometric Login response: $responseBody");

    return "";
  }

  Future<String> applyLoan(
      String appliedAmount, String limitAmount, String pin) async {
    var uuid = const Uuid();
    var Uid = uuid.v4();

    ApiClient apiClient = ApiClient();

    String strKey = apiClient.generateRandomString(16);
    String strIV = apiClient.generateRandomString(16);

    var serviceDetails = {
      "service": "LOAN",
      "action": "BASE",
      "command": "APPLICATION",
    };

    String? iMEI;

    var appDetails = {
      "AppId": '', // returned by GETCUSTOMER call and saved in the app
      "platform": "android",
      "CustomerId": '', // returned by GETCUSTOMER call and saved in the app
      "MobileNumber": '', // saved
      "device": iMEI ?? '', // saved or read
      "Lat": "0.200",
      "Lon": "-1.01",
    };

    var transactionDetails = {
      "F000": serviceDetails["service"],
      "F001": serviceDetails["action"],
      "F002": serviceDetails["command"],
      "F003": appDetails["AppId"],
      "F004": appDetails["CustomerId"],
      "F005": appDetails["MobileNumber"],
      "F006": "",
      "F007": encrypt(pin, publicKeyString), // request customer to enter PIN
      "F008": "PIN",
      "F009": appDetails["device"], // IMEI
      "F010": appDetails["device"],
      "F011": "YES", // PIN required, YES
      "F012": "",
      "F013": "",
      "F014": appDetails["platform"],
      "F015": "",
      "F016": "",
      "F017": "",
      "F018": "",
      "F019": "",
      "F020": "",
      "F021": appDetails["MobileNumber"], // MobileNumber
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
      "H00": Uid,
      "H03": Rsc,
      "H01": Rrk,
      "H02": Rrv,
      "H04": Aad
    };

    Map<String, String> coreRequest = {"Data": coreData};

    final authResultStr = await apiClient.authRequest(authRequest);

    final token = authResultStr;

    final coreResultStr =
        await apiClient.coreRequest(token, coreRequest, "APPLICATION");

    final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

    print("Decrypted: $coreDecryted");

    Map<String, dynamic> responseBody = jsonDecode(coreDecryted);

    print("Decrypted Loan Application response: $responseBody");

    return "";
  }

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
