import 'package:flutter/material.dart';
import '../models/models.dart';
import './widgets.dart';

class ProductsHomeOverview extends StatelessWidget {
  // Dummy List Data for Products type
  // TODO:Later Connect to Firebase
  List<ProductType> productTypes = [];
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: ListView.builder(
          // Item Count Connect to firebase
          itemCount: productTypes.length,
          itemBuilder: (BuildContext context, int index) {
            return ProductsType(productType: productTypes[index]);
          },
        ),
      ),
    );
  }
}
