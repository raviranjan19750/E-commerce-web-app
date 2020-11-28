import 'dart:html';

import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
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
    final List<Product> products = product;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 24.0),
            child: Divider(
              color: Colors.black,
              thickness: 0.5,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Palette.maroon,
            ),
            child: Text(
              productType.type,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
          ),
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
      ),
    );
  }
}
