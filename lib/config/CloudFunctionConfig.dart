import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:living_desire/config/strings.dart';
import 'package:universal_io/prefer_sdk/io.dart';

import 'function_config.dart';
import 'dart:js' as js;

class CloudFunctionConfig {
  static var res = "37b947579b10b34b066d1b01eb2636da1cba6f25";
  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json", // or whatever
    HttpHeaders.authorizationHeader:
        "Bearer 37b947579b10b34b066d1b01eb2636da1cba6f25",
  };

  static Future<http.Response> post(String endPoint, var data) async {
    return await http.post(FunctionConfig.host + endPoint,body: jsonEncode(data),
        headers: headers);
  }

  static Future<http.Response> put(String endPoint, var data) async {
    return await http.put(FunctionConfig.host + endPoint,
        body: jsonEncode(data), headers: headers);
  }

  static Future<http.Response> get(String endPoint) async {
    return await http.get(FunctionConfig.host + endPoint, headers: headers);
  }

  static Future<http.Response> delete(String endPoint) async {
    return await http.delete(FunctionConfig.host + endPoint, headers: headers);
  }
}
