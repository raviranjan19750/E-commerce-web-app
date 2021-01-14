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

  Future<String> manageDiscountCoupons(String authID, String promoCode) async {
    try {
      print(FunctionConfig.host +
          'manageDiscountCoupons/check-validity/$authID/$promoCode'.toString());
      final response = await http.post(FunctionConfig.host +
          'manageDiscountCoupons/check-validity/$authID/$promoCode');
      print(response.statusCode);
      switch (response.statusCode) {
        case 200:
          return response.body.toString();
          break;
        case 501:
          return response.body.toString();
          break;
        case 502:
          return response.body.toString();
          break;
        case 503:
          return response.body.toString();
          break;
        case 504:
          return response.body.toString();
          break;
        case 505:
          return response.body.toString();
          break;
        case 506:
          return response.body.toString();
          break;
        default:
          return "Can't Apply Coupon";
          return "Can't Apply Coupon";
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
