import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/user_detail.dart';

class UserdetailsRepository {
  Future<String> sendUserDetailsData(
      String name, String email, String phone, String uid) async {
    var data = {
      "name": name,
      "email": email,
      "phone": phone,
    };
    final response = await http.post(
      FunctionConfig.host + 'manageCustomerInfo/$uid',
      // body: jsonEncode(data),
      body: json.encode({
        "name": name,
        "email": email,
        "phone": phone,
      }),
      headers: {"Content-Type": "application/json"},
    );
    return response.body;
  }

  Future<UserDetail> getUserDetailsData(String uid) async {
    final response = await http.get(
      FunctionConfig.host + 'manageCustomerInfo/$uid',
    );
    Map<String, dynamic> data = jsonDecode(response.body);
    print("!!!!!!!!!!!!!!!!! " + response.body.toString());
    return UserDetail.fromJson(data);
  }
}
