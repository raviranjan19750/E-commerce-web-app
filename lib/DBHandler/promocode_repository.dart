import 'dart:convert';

import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';

class PromoCodeUtils {
  Future<dynamic> getUserReferallCode(String authID) async {
    try {
      final response = await CloudFunctionConfig.get(
          'manageDiscountCoupons/my-referral/$authID');
      // http.get(
      //     FunctionConfig.host + 'manageDiscountCoupons/my-referral/$authID');
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
      final response = await CloudFunctionConfig.post(
          'manageDiscountCoupons/check-validity/$authID/$promoCode', {});
      // http.post(FunctionConfig.host +
      //     'manageDiscountCoupons/check-validity/$authID/$promoCode');
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
        case 507:
          return response.body.toString();
          break;
        case 508:
          return response.body.toString();
          break;
        case 509:
          return response.body.toString();
          break;
        case 510:
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
