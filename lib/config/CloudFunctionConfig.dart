import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:living_desire/config/strings.dart';

import 'function_config.dart';

class CloudFunctionConfig{

  static Future<http.Response> post(String endPoint, var data) async {


     return await http.post(
       FunctionConfig.host + endPoint,body: jsonEncode(data),
       headers: {"Content-Type": "application/json","Authorization" : Strings.bearerToken},
     );


  }

  static Future<http.Response> put(String endPoint, var data) async {


    return await http.put(
      FunctionConfig.host + endPoint,body: jsonEncode(data),
      headers: {"Content-Type": "application/json","Authorization" : Strings.bearerToken},
    );


  }

  static Future<http.Response> get(String endPoint, var data) async {


    return await http.get(
      FunctionConfig.host + endPoint,
      headers: {"Content-Type": "application/json","Authorization" : Strings.bearerToken},
    );


  }

  static Future<http.Response> delete(String endPoint, var data) async {


    return await http.delete(
      FunctionConfig.host + endPoint,
      headers: {"Content-Type": "application/json","Authorization" : Strings.bearerToken},
    );


  }

}