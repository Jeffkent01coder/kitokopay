import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String elmsBaseUrl = 'https://kitokoapp.com/elms';

  static String username = 'L@T0wU8eR';
  static String password = 'TGF0MHdDb1IzU3Yz';
  static String basicAuth =
      'Basic ${base64Encode(utf8.encode('$username:$password'))}';

  static const String loadApiEndPoint = '$elmsBaseUrl/load';
  static const String authApiEndPoint = '$elmsBaseUrl/auth';
  static const String coreApiEndPoint = '$elmsBaseUrl/core';

  String generateRandomString(int length) {
    const characters =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    Random random = Random();
    return String.fromCharCodes(Iterable.generate(length,
        (_) => characters.codeUnitAt(random.nextInt(characters.length))));
  }

  Future<String> authRequest(Map<String, dynamic> auth) async {
    try {
      /*
      var headers = {
        'Content-Type': 'application/json',
      };

      print("Auth Request -------------");

      http.Response response = await http.post(
        Uri.parse(authApiEndPoint),
        headers: headers,
        body: json.encode(authRequest),
      );
      */

// Making the POST request

      final url = Uri.parse(authApiEndPoint);
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(auth),
      );

      print('Here is the Response');

      // Checking if the request was successful
      if (response.statusCode == 200) {
        // Successfully received response
        print("Server response: ${response.body}");
      } else {
        // Request failed
        print("Request failed with status: ${response.statusCode}");
      }
      return response.body;
      //  print("Auth Response -------------");
/*
      if (response.statusCode == 200) {
        print('Token Response : ${response.body}');
        return response.body;
      }
      */
    } on http.ClientException catch (e) {
      print("ClientException occurred: $e");
    } catch (e) {
      print(e.toString());
    }
    return "";
  }

  Future<String> coreRequest(
      String token, Map<String, dynamic> coreRequest, String command) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };
      print(coreRequest);

      http.Response response = await http.post(
        Uri.parse(coreApiEndPoint),
        headers: headers,
        body: jsonEncode(coreRequest),
      );

      print('Core RESPONSE: ${response.statusCode} $command');

      if (response.statusCode == 200) {
        print('Core RESPONSE: ${response.body}');
        return response.body;
      }
    } catch (e) {
      print(e);
    }
    return "";
  }
}
