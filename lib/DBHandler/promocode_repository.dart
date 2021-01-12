import 'dart:convert';

import 'package:living_desire/config/function_config.dart';
import 'package:http/http.dart' as http;

class PromoCodeUtils {
  Future<dynamic> getUserReferallCode(String authID) async {
    try {
      final response = await http.get(
          FunctionConfig.host + 'manageDiscountCoupons/my-referral/$authID');
      print(response.body);
      var ref = jsonDecode(response.body);
      return ref;
    } catch (e) {
      print(e.toString() + "getuserreferaalcode");
      throw Exception(e);
    }
  }

  Future<void> manageDiscountCoupons(String authID, String promoCode) async {
    try {
      final response = await http.get(FunctionConfig.host +
          'manageDiscountCoupons/check-validity/$authID/$promoCode');
    } catch (e) {}
  }
}
