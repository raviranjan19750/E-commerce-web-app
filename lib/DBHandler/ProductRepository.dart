import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/comboProduct.dart';

class ProductRepository {
  var LOG = LogBuilder.getLogger();

  Future<ProductDetail> getProductVariantDescription({String productID, String variantID, String authID}) async {
    LOG.i('Fetching Product Description for Product ID ${productID},  VarientId ${variantID} and $authID)');
    Map<String, dynamic> data = {
      "authID": authID,
    };
    final response = await http.post("https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProductDetails/details/$productID/$variantID",
        body: jsonEncode(data));

    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);
  }

  Future<ComboProduct> getComboProductDescription({String productID, String authID}) async {
    LOG.i('Fetching Combo Product Description for Product ID $productID and #$authID)');

    Map<String, dynamic> data = {
      "authID": authID,
    };
    final response = await http.post("https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageCombo/details/$productID/", body: jsonEncode(data));
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
        isInCart: result['data']['isInCart'],
        isInWishlist: result['data']['isInWishlist'],
        productVariant: List<Variant>.from(
            result["data"]["variants"].map((x) => Variant.fromJson(x))),
        isAvailable: result["data"]['isAvailable']);
  }

  Future<CheckProductAvailability> checkProductAvailability({String pincode, String productID, String variantID}) async {
    Map<String, dynamic> data = {
      "pincode": pincode,
      "productID": productID,
      "variantID": variantID,
    };

    var callable = FirebaseFunctions.instance.httpsCallable("checkPincodeAvailability");
    var result = await callable(data);
    return CheckProductAvailability.fromJson(result.data);
  }

  Future<dynamic> getSizeChart({String type, String subType}) async {

    LOG.i('Fetching size chart for type $type and #$subType)');

    Map<String, dynamic> data = {
      "type": type,
      "subType" : subType
    };
    
    final response = await http.post("https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageSizeChart/details", body: (data));
    var result = jsonDecode(response.body);
    print(result.toString());
    return result;

  }
}
