import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:living_desire/models/product_variants.dart';
import 'package:living_desire/models/products.dart';

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


}
