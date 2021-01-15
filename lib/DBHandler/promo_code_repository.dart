import 'package:living_desire/models/check_promo_code_availability.dart';

import 'dart:convert';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class PromoCodeRepository {
  var LOG = LogBuilder.getLogger();

  Future<CheckPromoCodeAvailability> checkPromoCodeAvailability({
    String promoCode,
    String authID,
    double payingAmount,
    int paymentMode,
  }) async {
    Map<String, dynamic> params = {
      "payingAmount": payingAmount,
      "paymentMode": paymentMode,
    };

    final response = await http.post(
        FunctionConfig.host +
            'manageDiscountCoupons/check-validity/${authID}/${promoCode}',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params));

    return CheckPromoCodeAvailability.fromJson(jsonDecode(response.body));
    // var callable = FirebaseFunctions.instance.httpsCallable("checkPincodeAvailability");
    // var result = await callable(data);
    //return CheckPromoCodeAvailability.fromJson(result.data);
  }
}
