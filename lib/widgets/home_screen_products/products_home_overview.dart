import 'package:flutter/material.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';
import '../widgets.dart';

class ProductsHomeOverview extends StatelessWidget {
  // Dummy List Data for Products type
  final List<ProductType> productTypes = productsType;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: productTypes.map((e) => ProductsType(productType: e)).toList(),
    );

    // return Expanded(
    //   child: Container(
    //     child: ListView.builder(
    //       // Item Count Connect to firebase
    //       itemCount: productTypes.length,
    //       itemBuilder: (BuildContext context, int index) {
    //         return ProductsType(productType: productTypes[index]);
    //       },
    //     ),
    //   ),
    // );
  }
}
