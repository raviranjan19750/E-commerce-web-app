import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  var LOG = LogBuilder.getLogger();

  Future<ProductDetail> getProductVariantDescription(
      {String productID, String variantID}) async {
    LOG.i(
        'Fetching Product Description for Product ID ${productID} and VarientId ${variantID}');
    final response = await http.get(
        "https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProductDetails/details/$productID/$variantID");
    Map<String, dynamic> map = jsonDecode(response.body);
    LOG.i(map);
    return ProductDetail.fromJson(map);

    //return ProductDetail.fromJson(jsonDecode(response.body));
  }

  Future<ProductDetail> getProductVariantSizeColorDescription(
      {String productID,String variantID, String color, String size}) async {
    var params = {"size": size, "colour": color};

    var response = await http.post(
        "https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProductDetails/details/$productID/$variantID",
        body: params);
    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);
  }

  Future<CheckProductAvailability> checkProductAvailability(
      {String pincode, String productID, String variantID}) async {
    Map<String, dynamic> data = {
      "pincode": pincode,
      "productID": productID,
      "variantID": variantID,
    };

    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable("checkPincodeAvailability");

    var result = await callable(data);
    //var map = jsonDecode(result.data);
    return CheckProductAvailability.fromJson(result.data);
  }
}
