import 'dart:convert';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:http/http.dart' as http;

class ProductRepository {


  Future<ProductDetail> getProductVariantDescription({String productID, String variantID}) async {
    
    final response = await http.get("http://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProducts/details/$productID/$variantID");
    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);

    //return ProductDetail.fromJson(jsonDecode(response.body));

  }


  Future<ProductDetail> getProductVariantSizeColorDescription({String productID, String color, String size}) async {

    var params = {
      "size" : size,
      "colour" : color
    };

    var uri = Uri.https('us-central1-livingdesire-2107-dev.cloudfunctions.net', '/manageProducts/details/$productID', params);
    var response = await http.get(uri);
    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);


  }


  


}
