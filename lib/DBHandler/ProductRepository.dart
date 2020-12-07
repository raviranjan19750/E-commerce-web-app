import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:living_desire/models/product_variants.dart';
import 'package:living_desire/models/products.dart';

class ProductRepository {
  final CollectionReference productsCollectionReference =
      FirebaseFirestore.instance.collection('products');
  final CollectionReference productVariantsCollectionReference =
      FirebaseFirestore.instance.collection('productVariants');

  Future<Products> getProductDetails({String productID}) async {
    try {
      var productData = await productsCollectionReference.doc(productID).get();
      return Products.fromMap(productData.data());
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<List<ProductVariants>> getProductVariantsDetail(
      {String productID}) async {
    try {
      var productVariantDetailsData = await productVariantsCollectionReference
          .where('productID', isEqualTo: productID)
          .get();
      if (productVariantDetailsData.docs.isNotEmpty) {
        return productVariantDetailsData.docs
            .map((snapshot) => ProductVariants.fromMap(snapshot.data()))
            .toList();
      } else {
        // Return statement
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
