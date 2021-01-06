import 'dart:html';

import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/widgets/labeltag/label_tag.dart';
import 'package:living_desire/widgets/productTypeBar.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../../models/models.dart';

class ProductsType extends StatelessWidget {
  final ProductType productType;

  const ProductsType({
    Key key,
    this.productType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Products List
    final List<Product> products = List();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ProductTypeBar(
        //   productType: productType.type,
        // ),
        LabelTag(productType.type,),
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return ProductItem(
                product: products[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
