@JS()
library living_desire;

import 'dart:convert';
import 'dart:io';
import 'dart:js_util';

import 'package:http/http.dart' as http;
import 'package:js/js.dart';
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'function_config.dart';

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
    var promise = secret_key();
    var res = await promiseToFuture(promise);
    LOG.i(res);
    try {
      return await http.post(FunctionConfig.host + endPoint,
          body: jsonEncode(data), headers: headers);
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  static Future<http.Response> put(String endPoint, var data) async {
    try {
      return await http.put(FunctionConfig.host + endPoint,
          body: jsonEncode(data), headers: headers);
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  static Future<http.Response> get(String endPoint) async {
    // var temp = await js.context.callMethod('secret_key');
    // LOG.i(temp);
    try {
      return await http.get(FunctionConfig.host + endPoint, headers: headers);
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }

  static Future<http.Response> delete(String endPoint) async {
    try {
      return await http.delete(FunctionConfig.host + endPoint,
          headers: headers);
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
    }
  }
}
