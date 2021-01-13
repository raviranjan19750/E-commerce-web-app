import 'dart:convert';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

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
      final response = await http.post(
          FunctionConfig.host + 'managePayments/get-buy-now/${authID}',
          body: params);
      LOG.i("Http Post request uy Now manage payments");
      if (response.statusCode == 200) {
        return BuyNowDetails.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<NormalCartDetails> getNormalCartDetails({
    String authID,
    String deliveryAddressID,
  }) async {
    try {
      var params = {"deliveryAddressID": deliveryAddressID};
      final response = await http.post(
          FunctionConfig.host + 'managePayments/get-normal-cart/${authID}',
          body: params);
      LOG.i("Http Post request Normal Cart manage payments");
      if (response.statusCode == 200) {
        return NormalCartDetails.fromJson(jsonDecode(response.body));
      } else {
        LOG.i(response.statusCode);
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<dynamic> createPaymentOrder({
    String authID,
    double amount,
  }) async {
    try {
      var params = {"amount": amount};
      final response = await http.post(
          FunctionConfig.host + 'managePayments/create-order/${authID}',
          body: params);
      LOG.i("Http Post request create order manage payments");
      if (response.statusCode == 200) {
        return (jsonDecode(response.body));
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
