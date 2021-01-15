import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/user_detail.dart';

class UserdetailsRepository {
  Future<dynamic> sendUserDetailsData(
      String name, String email, String phone, String uid) async {
    var data = {
      "name": name,
      "email": email,
      "phone": phone,
    };
    final response = await http.post(
      FunctionConfig.host + 'manageCustomerInfo/$uid',
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json","Authorization" : Strings.bearerToken},
    );
    // re render the user card

    var res = jsonDecode(response.body);
    return res;
    // print(response.body);
    // return response.body;
  }

  // Future<dynamic> getUserDetailsData(String uid) async {
  //   final response = await http.get(
  //     FunctionConfig.host + 'manageCustomerInfo/$uid',
  //   );
  //   print("!!!!!!!!!!!!!!!!! " + response.body.toString());
  //   // print(response.body);
  //   var ref = jsonDecode(response.body);
  //   return ref;
  //   // Map<String, dynamic> data = jsonDecode(response.body);
  //   // return UserDetail.fromJson(data);
  // }

  Future<dynamic> getUserDetailsData(String uid) async {
    try {
      final response =
          await http.get(FunctionConfig.host + 'manageCustomerInfo/$uid');
      print(response.body);
      var res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print(e.toString() + "getUserDetail");
      throw Exception(e);
    }
  }
}
