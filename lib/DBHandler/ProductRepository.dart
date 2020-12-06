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
    try {
      var productData = await productsCollectionReference.document(productID).get();
      return Products.fromMap(productData.data());
    } catch (e) {
        print(e.toString());
        throw Exception(e);

    }
  }


  Future<List<ProductVariants>> getProductVariantsDetail({String productID}) async {
    try {
      var productVariantDetailsData =
          await productsCollectionReference.getDocuments();
      if (productVariantDetailsData.documents.isNotEmpty) {
        return productVariantDetailsData.documents
            .map((snapshot) => ProductVariants.fromMap(snapshot.data()))
            .where((mappedItem) => mappedItem.productID == productID)
            .toList();
      }
    } catch (e) {

      print(e.toString());
      throw Exception(e);

    }
  }

// static Stream<DocumentSnapshot> getProductDetails({String productID}) {
//   // ignore: deprecated_member_use
//   return Firestore.instance
//       .collection("products")
//       // ignore: deprecated_member_use
//       .document(productID)
//       .snapshots();
// }
//
// static Stream<QuerySnapshot> getProductVariantsDetails({String productID}) {
//   // ignore: deprecated_member_use
//   return Firestore.instance
//       .collection("productVariants")
//       .where("productID" == productID)
//       .snapshots();
// }

}
