@JS()
library living_desire;

import 'dart:convert';
import 'dart:io';
import 'dart:js_util';

import 'package:http/http.dart' as http;
import 'package:js/js.dart';
import 'package:logger/logger.dart';
import 'function_config.dart';
import 'package:async/async.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'function_config.dart';

var LOG = Logger();

@JS()
external secret_key();

class AuthorizationSingleton {
  static final AuthorizationSingleton _authorizationSingleton =
      new AuthorizationSingleton._internal();
  AuthorizationSingleton._internal();
  static AuthorizationSingleton get instance => _authorizationSingleton;

  //members
  static String _token;
  final _initDBMemoizer = AsyncMemoizer<String>();

  Future<String> get tokenFromRemoteConfig async {
    if (_token != null) {
      return _token;
    }
    _token = await _initDBMemoizer.runOnce(() async {
      return await _initToken();
    });
    return _token;
  }

  Future<String> _initToken() async {
    var promise = secret_key();
    var res = await promiseToFuture(promise);

    return res;
  }
}

class CloudFunctionConfig {
  static Future<http.Response> post(String endPoint, var data) async {
    var res = await AuthorizationSingleton.instance.tokenFromRemoteConfig;
    try {
      return await http.post(FunctionConfig.host + endPoint,
          body: jsonEncode(data),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json", // or whatever
            HttpHeaders.authorizationHeader: "Bearer $res",
          });
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  static Future<http.Response> put(String endPoint, var data) async {
    var res = await AuthorizationSingleton.instance.tokenFromRemoteConfig;
    try {
      return await http.put(FunctionConfig.host + endPoint,
          body: jsonEncode(data),
          headers: {
            HttpHeaders.contentTypeHeader: "application/json", // or whatever
            HttpHeaders.authorizationHeader: "Bearer $res",
          });
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  static Future<http.Response> get(String endPoint) async {
    // var temp = await js.context.callMethod('secret_key');
    // LOG.i(temp);
    var res = await AuthorizationSingleton.instance.tokenFromRemoteConfig;
    try {
      return await http.get(FunctionConfig.host + endPoint, headers: {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "Bearer $res",
      });
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  static Future<http.Response> delete(String endPoint) async {
    var res = await AuthorizationSingleton.instance.tokenFromRemoteConfig;
    try {
      return await http.delete(FunctionConfig.host + endPoint, headers: {
        HttpHeaders.contentTypeHeader: "application/json", // or whatever
        HttpHeaders.authorizationHeader: "Bearer $res",
      });
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }
}
