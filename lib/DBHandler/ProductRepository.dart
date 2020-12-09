import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/services.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/product_variants.dart';
import 'package:living_desire/models/products.dart';
import 'package:http/http.dart' as http;

class ProductRepository {

  final CollectionReference productsCollectionReference =
      Firestore.instance.collection('products');
  final CollectionReference productVariantsCollectionReference =
      Firestore.instance.collection('productVariants');

  Future<Products> getProductDetails({String productID}) async {
    var productData = await productsCollectionReference.doc(productID).get();
    return Products.fromMap(productData.data());
  }


  // ignore: missing_return
  Future<List<ProductVariants>> getProductVariantsDetail({String productID}) async  {

    var productVariantDetailsData = await productVariantsCollectionReference.where("productID", isEqualTo: productID).get();
    return productVariantDetailsData.docs.map((snapshot) => ProductVariants.fromMap(snapshot.data())).toList();

  }


  Future<ProductDetail> getProductVariantDescription({String productID, String variantID}) async {
    
    final response = await http.get("http://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageProducts/details/${productID}/${variantID}");
    Map<String, dynamic> map = jsonDecode(response.body);
    return ProductDetail.fromJson(map);

    //return ProductDetail.fromJson(jsonDecode(response.body));

  }
  


}
