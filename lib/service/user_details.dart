import 'dart:convert';
import 'package:living_desire/config/CloudFunctionConfig.dart';

class UserdetailsRepository {
  Future<dynamic> sendUserDetailsData(
      String name, String email, String phone, String uid) async {
    var data = {
      "name": name,
      "email": email,
      "phone": phone,
    };
    final response =
        await CloudFunctionConfig.post('manageCustomerInfo/$uid', data);

    var res = jsonDecode(response.body);
    return res;
  }

  Future<dynamic> getUserDetailsData(String uid) async {
    try {
      final response = await CloudFunctionConfig.get('manageCustomerInfo/$uid');
      var res = jsonDecode(response.body);
      return res;
    } catch (e) {
      print(e.toString() + "getUserDetail");
      throw Exception(e);
    }
  }
}
