@JS()
library living_desire;

import 'package:js/js.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'function_config.dart';
import 'dart:js_util';


var LOG = Logger();

@JS()
external secret_key();

class CloudFunctionConfig {

  static var res = "37b947579b10b34b066d1b01eb2636da1cba6f25";
  static Map<String, String> headers = {
    HttpHeaders.contentTypeHeader: "application/json", // or whatever
    HttpHeaders.authorizationHeader:
        "Bearer 37b947579b10b34b066d1b01eb2636da1cba6f25",
  };

  static Future<http.Response> post(String endPoint, var data) async {
    // @TODO USe this token according to the need.
    var promise = secret_key();
    var res = await promiseToFuture(promise);
    LOG.i(res);
    return await http.post(FunctionConfig.host + endPoint,
        body: jsonEncode(data), headers: headers);
  }

  static Future<http.Response> put(String endPoint, var data) async {
    return await http.put(FunctionConfig.host + endPoint,
        body: jsonEncode(data), headers: headers);
  }

  static Future<http.Response> get(String endPoint) async {
    // var temp = await js.context.callMethod('secret_key');
    // LOG.i(temp);
    return await http.get(FunctionConfig.host + endPoint, headers: headers);
  }

  static Future<http.Response> delete(String endPoint) async {
    return await http.delete(FunctionConfig.host + endPoint, headers: headers);
  }
}
