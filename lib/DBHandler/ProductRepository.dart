import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:http/http.dart' as http;

class ProductRepository {
  Future<ProductDetail> getProductVariantDescription(
      {String productID, String variantID}) async {
    final response = await http.get(
        "http://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProducts/details/$productID/$variantID");
    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);

    //return ProductDetail.fromJson(jsonDecode(response.body));
  }

  Future<ProductDetail> getProductVariantSizeColorDescription(
      {String productID, String color, String size}) async {
    var params = {"size": size, "colour": color};

    var response = await http.post(
        "http://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProducts/details/$productID",
        body: params);
    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);
  }

  Future<CheckProductAvailability> checkProductAvailability(
      {String pincode, String productID, String warehouseID}) async {
    Map<String, dynamic> data = {
      "pincode": pincode,
      "productID": productID,
      "warehouseID": warehouseID,
    };

    HttpsCallable callable =
        FirebaseFunctions.instance.httpsCallable("checkPincodeAvailability");

    var result = await callable(data);
    var map = jsonDecode(result.data);
    return CheckProductAvailability.fromJson(map);
  }
}
