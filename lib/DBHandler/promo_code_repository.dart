import 'package:living_desire/config/CloudFunctionConfig.dart';
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
    double deliveryCharges,
    double walletAmount,
  }) async {
    Map<String, dynamic> params = {
      "payingAmount": payingAmount,
      "paymentMode": paymentMode,
      "deliveryCharges": deliveryCharges,
      "walletAmount": walletAmount
    };

    final response = await CloudFunctionConfig.post(
        'manageDiscountCoupons/check-validity/${authID}/${promoCode}', params);

    return CheckPromoCodeAvailability.fromJson(jsonDecode(response.body));
  }
}
