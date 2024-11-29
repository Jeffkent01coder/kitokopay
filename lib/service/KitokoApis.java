
import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.spec.GCMParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLContext;
import javax.net.ssl.TrustManager;
import javax.net.ssl.X509TrustManager;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.cert.X509Certificate;
import java.security.interfaces.RSAPublicKey;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;
import java.util.UUID;

public class KitokoApis {

    private static String basic_username = "L@T0wU8eR";
    private static String basic_password = "TGF0MHdDb1IzU3Yz";
    public static String publicKeyString = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA0OTq4FBkCO/5kZbBgt+7tHUKmqa6NSvzGnvo8Pia2C7moYDF77TGNcMk5Q5bYjE91QCauAYWxse2thARA1X6FjJz/jeVfYpcV43uuKd8FDaI7P7ah4A+WO4CTwRu95x2a5Hzg0y3qWsxuuBtBeV66uWzKtKcWObPwsblPjfgWkpAxhaIdWhnAk1cXDrukGLrzRIhdY+m3M6yyoW9E+htP9oSkhBF39TxjNtGM0vTSA/w9rVv3x1DGCc7hlvo8DOaj4aG60pdsA7VkVeBnEsXS/lba5dVRFCUHAlMUQfKVx7pZJ9fuHP9IZIfRE0wTPPZwqJSlU8/YQ0ARa5ic5NLjQIDAQAB";
    public static String LOAD_URL = "https://kitokoapp.com/elms/load";
    public static String AUTH_URL = "https://kitokoapp.com/elms/auth";
    public static String CORE_URL = "https://kitokoapp.com/elms/core";


    public static void main(String[] args) throws Exception {


        //  KitokoApis.GetCertificate();

        // KitokoApis.GetCustomerTestExisting();

        /*Response for GetCustomerTestExisting()
        * StatusCode:200
          {"Status":"000","Type":"object","Token":"","Data":"{\"Status\":\"pending\",\"AppId\":\"ELMSRWA001\",\"CustomerId\":\"2000000\"}"}
        * */

        // KitokoApis.ActivateTestExisting();

        /* Response for ActivateTestExisting()
        * StatusCode:401
          {"Status":"401","Type":"object","Data":"{\"DeviceId\":\"0FDFBBBCA01A842B256B2F049447D93F\",\"CustomerId\":\"2000000\",\"Display\":\"Dear customer, your activation code {000000} is valid. Please enter your PIN and Login\"}"}
        * */
        // KitokoApis.ReActivateTestExisting();
        /* Response for ReActivateTestExisting()
        * StatusCode:401
          {"Status":"401","Type":"object","Data":"{\"DeviceId\":\"0FDFBBBCA01A842B256B2F049447D93F\",\"CustomerId\":\"2000000\",\"Display\":\"Dear customer, your activation code {111111} is valid. Please enter your PIN and Login\"}"}
        * */
    //    KitokoApis.LoginTestExisting();
        /*
        Response for LoginTestExisting
        StatusCode:200
        {"Status":"000","Type":"object","Data":"{\"Loans\":\"[{\\\"LoanId\\\":\\\"11\\\",\\\"LoanStatus\\\":\\\"PendingPayment\\\",\\\"PrincipalAmount\\\":\\\"\\\",\\\"CurrentBalance\\\":\\\"\\\",\\\"Date\\\":\\\"21 October   2024 13:48:34\\\",\\\"ReferenceId\\\":\\\"141958\\\",\\\"RepaymentDate\\\":\\\"08 August 2024\\\",\\\"RequestType\\\":\\\"SELF\\\",\\\"MobileNumber\\\":\\\"250782000000\\\",\\\"Names\\\":\\\"John Doe\\\",\\\"Id\\\":\\\"2000000\\\"}]\",\"LoanBalance\":\"\",\"Rates\":\"{ \\\"RWF\\\" : \\\"1\\\" }\",\"Email\":\"info@helapay.biz\",\"LoanStatus\":\"PendingPayment\",\"Identification\":\"250782000000\",\"ProcessingFee\":\"\",\"LoanAmount\":\"\",\"ReferenceId\":\"141958\",\"Currency\":\"RWF\",\"LoanTermPeriod\":\"90 days\",\"DueDate\":\"08 August 2024\",\"InterestRate\":\"10%\",\"DateOfBirth\":\"\",\"LimitMessage\":\"Congratulations! you have qualified for maximum loan limit\",\"LimitStatus\":\"Success\",\"FirstName\":\"John\",\"LimitAmount\":\"100000\",\"OtherName\":null,\"CustomerId\":\"2000000\",\"LoanTermValue\":\"90\",\"IdentificationType\":\"ID\",\"MobileNumber\":\"250782000000\",\"Customers\":\"[{\\\"CustomerId\\\":\\\"2000000\\\",\\\"FirstName\\\":\\\"John\\\",\\\"LastName\\\":\\\"Doe\\\",\\\"Identification\\\":\\\"250782000000\\\",\\\"Email\\\":\\\"info@helapay.biz\\\",\\\"MobileNumber\\\":\\\"250782000000\\\"}]\",\"DisplayLimit\":\"RWF 100000\",\"ApplicationFee\":\"0.00\",\"Country\":\"Africa\",\"PaymentMethod\":null,\"LastName\":\"Doe\"}"}
        * */
        // KitokoApis.ApplyLoanTestExisting();
        /* Response for ApplyLoanTestExisting
        * StatusCode:200
          {"Status":"000","Type":"object","Token":"","Data":"{\"LoanAmount\":\"\",\"LoanId\":\"11\",\"LoanStatus\":\"PendingPayment\",\"PaymentMethod\":\"\",\"DueDate\":\"08 October 2024\"}"}
        *
        * */
        KitokoApis.LoanDetailsTestExisting();
        /*Response for LoanDetailsTestExisting
        * StatusCode:200
        {"Status":"000","Type":"object","Token":"","Data":"{\"Schedules\":\"[{\\\"id\\\":1,\\\"daysinperiod\\\":31,\\\"totalcredits\\\":0,\\\"fromdate\\\":\\\"2024-07-08\\\",\\\"duedate\\\":\\\"2024-08-08\\\",\\\"principaldue\\\":16018.000000,\\\"amountdueforperiod\\\":18018.000000,\\\"balance\\\":33982.000000}, {\\\"id\\\":2,\\\"daysinperiod\\\":31,\\\"totalcredits\\\":0,\\\"fromdate\\\":\\\"2024-08-08\\\",\\\"duedate\\\":\\\"2024-09-08\\\",\\\"principaldue\\\":16658.720000,\\\"amountdueforperiod\\\":18018.000000,\\\"balance\\\":17323.280000}, {\\\"id\\\":3,\\\"daysinperiod\\\":30,\\\"totalcredits\\\":0,\\\"fromdate\\\":\\\"2024-09-08\\\",\\\"duedate\\\":\\\"2024-10-08\\\",\\\"principaldue\\\":17323.280000,\\\"amountdueforperiod\\\":18016.210000,\\\"balance\\\":0.000000}]\",\"Transactions\":\"[{\\\"id\\\":21,\\\"type\\\":\\\"Disbursement\\\",\\\"date\\\":\\\"2024-07-08\\\",\\\"amount\\\":50000.000000,\\\"disbursalamount\\\":50000.000000,\\\"balance\\\":50000.000000,\\\"receiptnumber\\\":\\\"N/A\\\"}, {\\\"id\\\":22,\\\"type\\\":\\\"Accrual\\\",\\\"date\\\":\\\"2024-07-08\\\",\\\"amount\\\":4052.210000,\\\"disbursalamount\\\":50000.000000,\\\"balance\\\":0,\\\"receiptnumber\\\":\\\"N/A\\\"}]\",\"Details\":{\"TotalRepaymentExpected\":\"54052.21\",\"TotalPrincipalDisbursed\":\"50000.00\",\"Currency\":\"RWF\",\"PastDueDays\":\"\",\"TotalPrincipalExpected\":\"50000.00\",\"LoanTermInDays\":\"92\",\"id\":\"11\",\"PaymentBeforeDate\":\"\",\"InterestRate\":\"48.000000\",\"Principal\":\"50000.00\",\"TotalOutstanding\":\"54052.21\"}}"}
        * */
        // KitokoApis.ResetPinTestExisting();
        /* Response from ResetPinTestExisting
        * StatusCode:200
         {"Status":"000","Type":"string","Token":"","Data":"Dear customer, your request to reset your KitoKo PIN is successful. Please check your new PIN sent via email or sms and Login"}
        * */
    }

    public static String GetCertificate() {

        String Device = ""; // Read this from phone
        String Platform = "ANDROID"; // or IOS
        String Lat = ""; // Read this from app
        String Lon = ""; // read this from app

        String request = "{\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";
        System.out.println(request);

        String response = LoadHttpPost(LOAD_URL, request);

        System.out.println(response);

        return response;
    }

    public static String GetCustomerTestExisting() throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();

        String service = "PROFILE";
        String action = "BASE";
        String command = "GETCUSTOMER";//

        String AppId = "";
        String Platform = "ANDROID";// ANDROID or IOS

        String CustomerId = "";
        String MobileNumber = "250782000000";
        String Device = "";

        String Lat = "0.200"; // read this
        String Lon = "-1.01"; // read this

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "";
        String F008 = "";
        String F009 = Device;// read this from phone IMEI
        String F010 = Device; // deviceid read this from phone

        String F011 = "";
        String F012 = "";
        String F013 = "";
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";

        String F021 = ""; //
        String F022 = "";//
        String F023 = "";//
        String F024 = "";//
        String F025 = "";//
        String F026 = "";//
        String F027 = ""; //
        String F028 = ""; //
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        String hashedTrxData = Hash(trxData, Device);

        System.out.println("**************** trxData ************");

        System.out.println(trxData);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();
        System.out.println("**************** appData ************");

        System.out.println(appData);

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String authRequest = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        System.out.println("**************** authRequest ************");
        System.out.println(authRequest);

        System.out.println("**************** coreRequest ************");
        System.out.println(coreRequest);

        final String authResultStr = authHttpPost(AUTH_URL, authRequest);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }

    public static String GetCustomerTestExisting(String MobileNumber, String Platform) throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();

        String service = "PROFILE";
        String action = "BASE";
        String command = "GETCUSTOMER";//

        String AppId = "";
        //  String Platform = "ANDROID";// ANDROID or IOS or WEB

        String CustomerId = "";
        // String MobileNumber = "250782000000";
        String Device = "";

        String Lat = "0.200"; // read this
        String Lon = "-1.01"; // read this

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "";
        String F008 = "";
        String F009 = Device;// read this from phone IMEI
        String F010 = Device; // deviceid read this from phone

        String F011 = "";
        String F012 = "";
        String F013 = "";
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";

        String F021 = ""; //
        String F022 = "";//
        String F023 = "";//
        String F024 = "";//
        String F025 = "";//
        String F026 = "";//
        String F027 = ""; //
        String F028 = ""; //
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        String hashedTrxData = Hash(trxData, Device);

        System.out.println("**************** trxData ************");

        System.out.println(trxData);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();
        System.out.println("**************** appData ************");

        System.out.println(appData);

        String strKey = "lbXDF0000yxrG24B"; // generate these keys randomly
        String strIV = "HlPGoH11117Pf5sv";// generate these keys randomly

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String authRequest = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        System.out.println("**************** authRequest ************");
        System.out.println(authRequest);

        System.out.println("**************** coreRequest ************");
        System.out.println(coreRequest);

        final String authResultStr = authHttpPost(AUTH_URL, authRequest);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }

    public static String LoginTestExisting(String AppId, String Platform, String CustomerId, String MobileNumber, String Pin, String Device) throws Exception {

        String service = "PROFILE";
        String action = "BASE";
        String command = "LOGIN";

        //  String AppId = "ELMSRWA001"; // AppId returned by GETCUSTOMER
        //  String Platform = "ANDROID"; // ANDROID or IOS or WEB

        // String CustomerId = ""; // CustomerId returned by GETCUSTOMER and Saved in this app for future use

        // COD Tested
        // String CustomerId = "2000000";
        // String MobileNumber = "250782000000";
        // String Device = "0FDFBBBCA01A842B256B2F049447D93F";

        String Lat = "0.200";
        String Lon = "-1.01";
        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();
        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = Pin;// PIN received via email or sms
        String F008 = "PIN";// this is static
        String F009 = Device;// IMEI
        String F010 = Device;

        publicKeyString = GetCertificate();

        F007 = encrypt(F007, publicKeyString);

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F014\":\"" + Platform + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        System.out.println(appData);

        System.out.println(trxData);
        String hashedTrxData = Hash(trxData, Device);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";


        final String auth_request = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, auth_request);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;
    }

    public static String ActivateTestExisting() throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();

        String service = "PROFILE";
        String action = "BASE";
        String command = "ACTIVATE";

        String AppId = "ELMSRWA001"; // this was returned from GetCustomer: it should be saved permantly
        String Platform = "IOS";

        String CustomerId = "2000000";
        String MobileNumber = "250782000000";

        String Device = "";

        String Lat = "0.200";
        String Lon = "-1.01";

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "";
        String F008 = "PIN";
        String F009 = Device;// IMEI
        String F010 = Device;


        String F011 = ""; //
        String F012 = "";//
        String F013 = "000000";// OTP sent via email
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";

        String F021 = ""; //
        String F022 = "";//
        String F023 = "";//
        String F024 = "";//
        String F025 = "";//
        String F026 = "";//
        String F027 = ""; //
        String F028 = ""; //
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";


        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        System.out.println(trxData);
        String hashedTrxData = Hash(trxData, Device);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String auth_request = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, auth_request);
        System.out.println("**************** authResultStr *****************");
        System.out.println(authResultStr);
        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }

    public static String ReActivateTestExisting() throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();
        String service = "PROFILE";
        String action = "BASE";
        String command = "REACTIVATE";

        String AppId = "ELMSRWA001";
        String Platform = "IOS";

        String CustomerId = "2000000";
        String MobileNumber = "250782000000";
        String Device = "";

        String Lat = "0.200";
        String Lon = "-1.01";

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "";
        String F008 = "PIN";
        String F009 = Device;// IMEI
        String F010 = Device;


        String F011 = ""; //
        String F012 = "";//
        String F013 = "111111";// OTP sent via email
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";

        String F021 = ""; //
        String F022 = "";//
        String F023 = "";//
        String F024 = "";//
        String F025 = "";//
        String F026 = "";//
        String F027 = ""; //
        String F028 = ""; //
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        System.out.println(trxData);
        String hashedTrxData = Hash(trxData, Device);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String auth_request = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, auth_request);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }

    public static String ResetPinTestExisting() throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();
        String service = "PROFILE";
        String action = "BASE";
        String command = "RESETPIN";

        String AppId = "ELMSRWA001";
        String Platform = "IOS";

        String CustomerId = "2000000";
        String MobileNumber = "250782000000";
        String Device = "0FDFBBBCA01A842B256B2F049447D93F";


        String Lat = "0.200";
        String Lon = "-1.01";

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "";
        String F008 = "PIN";
        String F009 = Device;// IMEI
        String F010 = Device;


        String F011 = ""; //
        String F012 = "";//
        String F013 = "";// OTP sent via email
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";


        String F021 = ""; //
        String F022 = "";//
        String F023 = "";//
        String F024 = "";//
        String F025 = "";//
        String F026 = "";//
        String F027 = ""; //
        String F028 = ""; //
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        System.out.println(trxData);
        String hashedTrxData = Hash(trxData, Device);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String auth_request = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, auth_request);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }

    public static String LoginTestExisting() throws Exception {

        String service = "PROFILE";
        String action = "BASE";
        String command = "LOGIN";

        String AppId = "ELMSRWA001"; // AppId returned by GETCUSTOMER
        String Platform = "IOS";

        // COD Tested
        String CustomerId = "2000000";
        String MobileNumber = "250782000000";
        String Device = "0FDFBBBCA01A842B256B2F049447D93F";

        String Lat = "0.200";
        String Lon = "-1.01";
        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();
        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "1234";// PIN received via email or sms
        String F008 = "PIN";// this is static
        String F009 = Device;// IMEI
        String F010 = Device;

        publicKeyString = GetCertificate();
        F007 = encrypt(F007, publicKeyString);

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F014\":\"" + Platform + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        System.out.println(appData);

        System.out.println("TRX DATA: " + trxData);
        String hashedTrxData = Hash(trxData, Device);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";


        final String auth_request = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, auth_request);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;
    }

    public static String ChangeLoginTestExisting() throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();
        String service = "PROFILE";
        String action = "BASE";
        String command = "CHANGELOGIN";

        String AppId = "ELMSRWA001";
        String Platform = "ANDROID";

/*
250782647985
* 13000000
* */
/*
        String CustomerId = "1000000";
        String MobileNumber = "250782647985";
        String Device = "CA3D6170DAAA45ACAF24FED75B897CC3";
        */
        /*
                String CustomerId = "2000000";
        String MobileNumber = "250783200510";
        String Device = "AA3D6170DAAA45ACAF24FED75B897AA3";

        * */
        String CustomerId = "2000000";
        String MobileNumber = "250783200510";
        String Device = "AA3D6170DAAA45ACAF24FED75B897AA3";

        String Lat = "0.200";
        String Lon = "-1.01";

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "8040";
        String F008 = "PIN";
        String F009 = Device;// IMEI
        String F010 = Device;


        String F011 = ""; //
        String F012 = "0101";//
        String F013 = "";// OTP sent via email
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";


        String F021 = ""; //
        String F022 = "";//
        String F023 = "";//
        String F024 = "";//
        String F025 = "";//
        String F026 = "";//
        String F027 = ""; //
        String F028 = ""; //
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";
        F007 = encrypt(F007, publicKeyString);
        F012 = encrypt(F012, publicKeyString);

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        System.out.println(trxData);
        String hashedTrxData = Hash(trxData, Device);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String auth_request = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, auth_request);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }

    public static String ApplyLoanTestExisting() throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();

        String service = "LOAN";
        String action = "BASE";
        String command = "APPLICATION";//

        String AppId = "ELMSRWA001";
        String Platform = "IOS";        String CustomerId = "2000000";
        String MobileNumber = "250782000000";
        String Device = "0FDFBBBCA01A842B256B2F049447D93F";

        String Lat = "0.200";
        String Lon = "-1.01";

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "0000";
        String F008 = "PIN";
        String F009 = Device;// IMEI
        String F010 = Device;

        String F011 = "YES";// PIN required, YES
        String F012 = "";
        String F013 = "";
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";

        String F021 = MobileNumber; // MobileNumber
        String F022 = "000000";// NationalId
        String F023 = "50000";// AppliedAmount
        String F024 = "500000";// LimitAmount
        String F025 = "25000110";// Dummy Reference
        String F026 = "";//
        String F027 = ""; // DOB
        String F028 = ""; // Email Address
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";


        F007 = encrypt(F007, publicKeyString);

        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        String hashedTrxData = Hash(trxData, Device);

        System.out.println(trxData);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String authRequest = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, authRequest);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }

    public static String LoanDetailsTestExisting() throws Exception {

        UUID uuid = UUID.randomUUID();
        String Uid = uuid.toString();

        publicKeyString = GetCertificate();
        String service = "LOAN";
        String action = "BASE";
        String command = "DETAILS";//

        String AppId = "ELMSRWA001";
        String Platform = "IOS";

        String CustomerId = "2000000";
        String MobileNumber = "250782000000";
        String Device = "0FDFBBBCA01A842B256B2F049447D93F";


        String Lat = "0.200";
        String Lon = "-1.01";

        String Rsc; // Rsa Somme de Control
        String Rrk; // Rsa Random Key
        String Rrv; // Rsa Random Vector
        String Aad;// Aes App Data

        String F000 = service;
        String F001 = action;
        String F002 = command;
        String F003 = AppId;
        String F004 = CustomerId;
        String F005 = MobileNumber;
        String F006 = "";
        String F007 = "";
        String F008 = "PIN";
        String F009 = Device;// IMEI
        String F010 = Device;

        String F011 = "";// PIN required, YES
        String F012 = "";
        String F013 = "";
        String F014 = Platform;
        String F015 = "";
        String F016 = "";
        String F017 = "";
        String F018 = "";
        String F019 = "";
        String F020 = "";

        String F021 = MobileNumber; // MobileNumber
        String F022 = "11";// LoanId from LOGIN Loans
        String F023 = "";//
        String F024 = "";//
        String F025 = "";//
        String F026 = "";//
        String F027 = ""; // DOB
        String F028 = ""; // Email Address
        String F029 = "";
        String F030 = "";

        String F031 = "";
        String F032 = "";
        String F033 = "";
        String F034 = "";
        String F035 = "";
        String F036 = "";
        String F037 = "";
        String F038 = "";
        String F039 = "";
        String F040 = "";


        // F007 = encrypt( F007,publicKeyString);


        String trxData = "{\"F000\":\"" + F000 + "\",\"F001\":\"" + F001 + "\",\"F002\":\"" + F002 + "\",\"F003\":\"" + F003 + "\",\"F004\":\"" + F004 + "\",\"F005\":\"" + F005 + "\",\"F006\":\"" + F006 + "\",\"F007\":\"" + F007 + "\",\"F008\":\"" + F008 + "\",\"F009\":\"" + F009 + "\",\"F010\":\"" + F010 + "\",\"F011\":\"" + F011 + "\",\"F012\":\"" + F012 + "\",\"F013\":\"" + F013 + "\",\"F014\":\"" + F014 + "\",\"F015\":\"" + F015 + "\",\"F016\":\"" + F016 + "\",\"F017\":\"" + F017 + "\",\"F018\":\"" + F018 + "\",\"F019\":\"" + F019 + "\",\"F020\":\"" + F020 + "\",\"F021\":\"" + F021 + "\",\"F022\":\"" + F022 + "\",\"F023\":\"" + F023 + "\",\"F024\":\"" + F024 + "\",\"F025\":\"" + F025 + "\",\"F026\":\"" + F026 + "\",\"F027\":\"" + F027 + "\",\"F028\":\"" + F028 + "\",\"F029\":\"" + F029 + "\",\"F030\":\"" + F030 + "\",\"F031\":\"" + F031 + "\",\"F032\":\"" + F032 + "\",\"F033\":\"" + F033 + "\",\"F034\":\"" + F034 + "\",\"F035\":\"" + F035 + "\",\"F036\":\"" + F036 + "\",\"F037\":\"" + F037 + "\",\"F038\":\"" + F038 + "\",\"F039\":\"" + F039 + "\",\"F040\":\"" + F040 + "\"}";

        String appData = "{\"UniqueId\":\"" + Uid + "\",\"AppId\":\"" + AppId + "\",\"Device\":\"" + Device + "\",\"Platform\":\"" + Platform + "\",\"CustomerId\":\"" + CustomerId + "\",\"MobileNumber\":\"" + MobileNumber + "\",\"Lat\":\"" + Lat + "\",\"Lon\":\"" + Lon + "\"}";

        String hashedTrxData = Hash(trxData, Device);

        System.out.println(trxData);
        System.out.println();
        System.out.println(hashedTrxData);
        System.out.println();

        String strKey = "lbXDF0000yxrG24B";
        String strIV = "HlPGoH11117Pf5sv";

        Rsc = hashedTrxData;
        Rrk = encrypt(strKey, publicKeyString);
        Rrv = encrypt(strIV, publicKeyString);
        Aad = encrypt(appData, strKey, strIV);

        String coreData = encrypt(trxData, strKey, strIV);

        coreData = "{\"Data\":\"" + coreData + "\"}";

        final String authRequest = "{\"H00\":\"" + Uid + "\",\"H03\":\"" + Rsc + "\",\"H01\":\"" + Rrk + "\",\"H02\":\"" + Rrv + "\",\"H04\":\"" + Aad + "\"}";

        final String coreRequest = coreData;

        final String authResultStr = authHttpPost(AUTH_URL, authRequest);

        final String coreResultStr = coreHttpPost(CORE_URL, authResultStr, coreRequest);

        final String coreDecryted = decrypt(coreResultStr, strKey, strIV);

        System.out.println(coreDecryted);

        return coreDecryted;

    }
    // START RSA

    public static String encrypt(String textToEncrypt, String publicKeyString) {
        try {
            PublicKey publicKey = getPublicKeyFromString(publicKeyString);
            byte[] encryptedData = EncryptData(textToEncrypt, (RSAPublicKey) publicKey);
            return Base64.getEncoder().encodeToString(encryptedData);
        } catch (Exception ex) {
            System.out.println(ex.toString());
            return "";
        }
    }

    public static byte[] EncryptData(String data, RSAPublicKey publicKey) {
        try {
            Cipher cipher = Cipher.getInstance("RSA");
            cipher.init(Cipher.ENCRYPT_MODE, publicKey);
            byte[] plaintextBytes = data.getBytes("UTF-8");
            return cipher.doFinal(plaintextBytes);
        } catch (Exception ex) {
            System.out.println(ex.toString());
            return new byte[0];
        }
    }

    public static PublicKey getPublicKeyFromString(String publicKeyString) {
        try {
            byte[] bytes = Base64.getDecoder().decode(publicKeyString);
            X509EncodedKeySpec keySpec = new X509EncodedKeySpec(bytes);
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
            return keyFactory.generatePublic(keySpec);
        } catch (Exception ex) {
            throw new RuntimeException("Failed to parse public key: " + ex.getMessage(), ex);
        }
    }

    // END RSA

    // START AES

    public static String encrypt(String data, String keyStr, String ivStr) throws Exception {
        // Static 16-byte (128-bit) key and IV
        byte[] keyBytes = keyStr.getBytes("UTF-8");
        byte[] iv = ivStr.getBytes("UTF-8");

        String plaintext = data;

        SecretKey secretKey = new SecretKeySpec(keyBytes, "AES");

        // Create the AES-GCM cipher object
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");

        // Encryption
        cipher.init(Cipher.ENCRYPT_MODE, secretKey, new GCMParameterSpec(128, iv));
        byte[] encryptedText = cipher.doFinal(plaintext.getBytes("UTF-8"));
        return Base64.getEncoder().encodeToString(encryptedText);
    }

    public static String decrypt(String data, String keyStr, String ivStr) throws Exception {
        // Static 16-byte (128-bit) key and IV
        byte[] keyBytes = keyStr.getBytes("UTF-8");
        byte[] iv = ivStr.getBytes("UTF-8");

        SecretKey secretKey = new SecretKeySpec(keyBytes, "AES");

        // Create the AES-GCM cipher object
        Cipher cipher = Cipher.getInstance("AES/GCM/NoPadding");

        byte[] encryptedBytes = Base64.getDecoder().decode(data);
        // Decryption
        cipher.init(Cipher.DECRYPT_MODE, secretKey, new GCMParameterSpec(128, iv));
        byte[] decryptedText = cipher.doFinal(encryptedBytes);

        return new String(decryptedText, "UTF-8");
    }


    public static String rsaDecryption(String encryptedString) {
        try {
            String password = "Latom_cert@123";
            KeyStore keyStore = KeyStore.getInstance("PKCS12");

            String pfxFilePath = "C:\\Projects\\Amenipa\\Cert\\Latom_cert.pfx";
            FileInputStream fis = new FileInputStream(pfxFilePath);

            keyStore.load(fis, password.toCharArray());

            String alias = keyStore.aliases().nextElement();

            PrivateKey privateKey = (PrivateKey) keyStore.getKey(alias, password.toCharArray());

            byte[] encryptedBytes = Base64.getDecoder().decode(encryptedString.getBytes("UTF-8"));

            return decrypt(encryptedBytes, privateKey);
        } catch (Exception e) {
            e.printStackTrace();
            return "";
        }
    }

    private static String decrypt(byte[] encryptedData, PrivateKey privateKey) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA/ECB/PKCS1Padding");
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedData);
        return new String(decryptedBytes);
    }

    // START HTTP
    private static String LoadHttpPost(String endpoint, String json) {
        HttpURLConnection connection = null;
        int statusCode = 0;
        String responseMessage = "";
        try {
            // Bypass certificate validation (for testing purposes)
            TrustManager[] trustAllCerts = new TrustManager[]{
                    new X509TrustManager() {
                        public X509Certificate[] getAcceptedIssuers() {
                            return null;
                        }

                        public void checkClientTrusted(X509Certificate[] certs, String authType) {
                        }

                        public void checkServerTrusted(X509Certificate[] certs, String authType) {
                        }
                    }
            };

            // Install the all-trusting trust manager
            SSLContext sslContext = SSLContext.getInstance("SSL");
            sslContext.init(null, trustAllCerts, new SecureRandom());
            HttpsURLConnection.setDefaultSSLSocketFactory(sslContext.getSocketFactory());

            String basicHeader = String.format("%s:%s", basic_username, basic_password);
            basicHeader = encode(basicHeader);

            URL url = new URL(endpoint);
            connection = (HttpURLConnection) url.openConnection();
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            connection.setRequestProperty("Authorization", "Basic " + basicHeader);

            OutputStreamWriter streamWriter = new OutputStreamWriter(connection.getOutputStream());
            streamWriter.write(json);
            streamWriter.flush();
            StringBuilder stringBuilder = new StringBuilder();
            statusCode = connection.getResponseCode();
            if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                InputStreamReader streamReader = new InputStreamReader(connection.getInputStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                responseMessage = stringBuilder.toString();
                return responseMessage;
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_BAD_REQUEST) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                responseMessage = stringBuilder.toString();
                return responseMessage;
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_NOT_FOUND) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                responseMessage = stringBuilder.toString();
                return responseMessage;
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_UNAUTHORIZED) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                responseMessage = stringBuilder.toString();
                return responseMessage;
            } else {
                responseMessage = connection.getResponseMessage();
                return responseMessage;
            }
        } catch (Exception exception) {
            statusCode = 500;
            responseMessage = exception.getMessage();
            return responseMessage;
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
            System.out.println(statusCode);
            System.out.println(responseMessage);
        }
    }

    public static String authHttpPost(String authUrl, String json) {
        HttpURLConnection connection = null;
        try {
            System.out.println("URL:");
            System.out.println(authUrl);
            URL url = new URL(authUrl);
            connection = (HttpURLConnection) url.openConnection();
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            OutputStreamWriter streamWriter = new OutputStreamWriter(connection.getOutputStream());
            streamWriter.write(json);
            streamWriter.flush();
            StringBuilder stringBuilder = new StringBuilder();
            if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                InputStreamReader streamReader = new InputStreamReader(connection.getInputStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_BAD_REQUEST) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_NOT_FOUND) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_UNAUTHORIZED) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else {
                System.out.println(connection.getResponseMessage());
                return connection.getResponseMessage();
            }
        } catch (Exception exception) {
            System.out.println(exception.toString());
            return null;
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    public static String coreHttpPost(String coreUrl, String header, String json) {
        HttpURLConnection connection = null;
        try {
            URL url = new URL(coreUrl);
            connection = (HttpURLConnection) url.openConnection();
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestMethod("POST");
            connection.setRequestProperty("Content-Type", "application/json");
            connection.setRequestProperty("Accept", "application/json");
            connection.addRequestProperty("Authorization", "Bearer " + header);

            OutputStreamWriter streamWriter = new OutputStreamWriter(connection.getOutputStream());
            streamWriter.write(json);
            streamWriter.flush();
            StringBuilder stringBuilder = new StringBuilder();
            int statusCode = connection.getResponseCode();
            System.out.println("StatusCode:");
            System.out.println(statusCode);
            if (statusCode == HttpURLConnection.HTTP_OK) {
                InputStreamReader streamReader = new InputStreamReader(connection.getInputStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_BAD_REQUEST) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_NOT_FOUND) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else if (connection.getResponseCode() == HttpURLConnection.HTTP_UNAUTHORIZED) {
                InputStreamReader streamReader = new InputStreamReader(connection.getErrorStream());
                BufferedReader bufferedReader = new BufferedReader(streamReader);
                String response = null;
                while ((response = bufferedReader.readLine()) != null) {
                    stringBuilder.append(response);
                }
                bufferedReader.close();
                System.out.println(stringBuilder.toString());
                return stringBuilder.toString();
            } else {
                System.out.println(connection.getResponseMessage());
                return connection.getResponseMessage();
            }
        } catch (Exception exception) {
            System.out.println(exception.toString());
            return null;
        } finally {
            if (connection != null) {
                connection.disconnect();
            }
        }
    }

    // END HTTP
    // START HASH-256
    public static String Hash(String data, String salt) throws NoSuchAlgorithmException {

        String originalString = data + salt;
        MessageDigest digest = MessageDigest.getInstance("SHA-256");
        byte[] encodedhash = digest.digest(
                originalString.getBytes(StandardCharsets.UTF_8));
        return bytesToHex(encodedhash);
    }

    private static String bytesToHex(byte[] hash) {
        StringBuilder hexString = new StringBuilder(2 * hash.length);
        for (int i = 0; i < hash.length; i++) {
            String hex = Integer.toHexString(0xff & hash[i]);
            if (hex.length() == 1) {
                hexString.append('0');
            }
            hexString.append(hex);
        }
        return hexString.toString();
    }
    // END HASH-256

    public static String encode(String value) {
        byte[] encodedBytes = Base64.getEncoder().encode(value.getBytes(StandardCharsets.UTF_8));
        return new String(encodedBytes, StandardCharsets.UTF_8);
    }

}
