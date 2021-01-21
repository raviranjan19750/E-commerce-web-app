import 'dart:convert';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:sentry_flutter/sentry_flutter.dart';

class SelectAddressTypeRepository {
  // Get Address Details
  var LOG = LogBuilder.getLogger();

  Future<BuyNowDetails> getBuyNowDetails({
    String authID,
    String productID,
    String variantID,
    String deliveryAddressID,
  }) async {
    try {
      var params = {
        "productID": productID,
        "variantID": variantID,
        "deliveryAddressID": deliveryAddressID
      };
      final response = await CloudFunctionConfig.post(
          'managePayments/get-buy-now/${authID}', params);

      LOG.i("Http Post request uy Now manage payments");
      if (response.statusCode == 200) {
        return BuyNowDetails.fromJson(jsonDecode(response.body));
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  Future<NormalCartDetails> getNormalCartDetails({
    String authID,
    String deliveryAddressID,
  }) async {
    try {
      var params = {"deliveryAddressID": deliveryAddressID};
      final response = await CloudFunctionConfig.post(
          'managePayments/get-normal-cart/${authID}', params);

      LOG.i("Http Post request Normal Cart manage payments");
      if (response.statusCode == 200) {
        return NormalCartDetails.fromJson(jsonDecode(response.body));
      } else {
        LOG.i(response.statusCode);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  Future<dynamic> createPaymentOrder({
    String authID,
    double amount,
  }) async {
    try {
      var params = {"amount": amount};
      final response = await CloudFunctionConfig.post(
          'managePayments/create-order/${authID}', params);

      LOG.i("Http Post request create order manage payments");
      if (response.statusCode == 200) {
        return (jsonDecode(response.body));
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }
}
