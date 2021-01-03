import 'dart:convert';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/models/comboProduct.dart';

class ProductRepository {
  var LOG = LogBuilder.getLogger();

  Future<ProductDetail> getProductVariantDescription({String productID, String variantID}) async {
    LOG.i('Fetching Product Description for Product ID ${productID} and VarientId ${variantID}');
    final response = await http.get("https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProductDetails/details/$productID/$variantID");
    Map<String, dynamic> map = jsonDecode(response.body);
    LOG.i(map);
    return ProductDetail.fromJson(map);

  }

  Future<ComboProduct> getComboProductDescription({String productID}) async {
    LOG.i('Fetching Combo Product Description for Product ID $productID');

    final response = await http.get("https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageCombo/details/$productID/");
    var result = jsonDecode(response.body);

    List<String> imgUrls = List();
    for (var img in result["data"]['images']) {
      imgUrls.add(img.toString());
    }

    List<String> descriptions = List();
    for (var desc in result["data"]['description']) {
      descriptions.add(desc.toString());
    }

    return ComboProduct(
      title: result["data"]["name"],
      imageUrls: imgUrls,
      descriptions: descriptions,
      discountPrice: result["data"]['discountPrice'],
      retailPrice: result["data"]['sellingPrice'],
      productId: result['id'],
      isAvailable: result["data"]['isAvailable']
    );


  }

  Future<ProductDetail> getProductVariantSizeColorDescription({String productID,String variantID, String color, String size}) async {

    LOG.i('Fetching Product Variant Description for Product ID $productID Variant I $variantID Color $color and Size $size ');
    var response = await http.get("https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProductDetails/details/$productID/$variantID");
    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);
  }

  Future<CheckProductAvailability> checkProductAvailability({String pincode, String productID, String variantID}) async {
    Map<String, dynamic> data = {
      "pincode": pincode,
      "productID": productID,
      "variantID": variantID,
    };

    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable("checkPincodeAvailability");
    var result = await callable(data);
    return CheckProductAvailability.fromJson(result.data);
  }
}
