import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/models/productVariantColorModel.dart';

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
  }
  //return ProductDetail.fromJson(jsonDecode(response.body));

  // String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
  //     '${alpha.toRadixString(16).padLeft(2, '0')}'
  //     '${red.toRadixString(16).padLeft(2, '0')}'
  //     '${green.toRadixString(16).padLeft(2, '0')}'
  //     '${blue.toRadixString(16).padLeft(2, '0')}';

  Future<ProductDetail> getProductVariantSizeColorDescription(
      {String productID, List<ProductVariantColor> color, String size}) async {
    List<String> colors = [];
    for (var c in color) {
      colors.add(
          ('#' + c.colorHexCode.toString().substring(10, 16).toUpperCase()));
    }
    var params = {"size": size, "colour": colors};
    print(params);

    var response = await http.post(
        "https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProductDetails/details/$productID",
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params));
    Map<String, dynamic> map = jsonDecode(response.body);
    print('Http request sucessfull');
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
    //var map = jsonDecode(result.data);
    return CheckProductAvailability.fromJson(result.data);
  }
}
