import 'package:living_desire/config/function_config.dart';
import 'package:http/http.dart' as http;

class PromoCodeUtils {
  Future<String> getUserReferallCode(String authID) async {
    try {
      final response = await http.get(
          FunctionConfig.host + 'manageCouponDiscounts/my-referral/$authID');
      return response.body.toString();
    } catch (e) {
      print(e.toString());
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
