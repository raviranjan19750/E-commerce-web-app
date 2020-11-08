import 'package:flutter/material.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../models/models.dart';

class ProductsType extends StatelessWidget {
  final ProductType productType;

  const ProductsType({
    Key key,
    this.productType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Products List
    List<Product> products = [];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FlatButton(
          onPressed: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(productType.type),
              const SizedBox(
                width: 10.0,
              ),
              Icon(Icons.arrow_forward_ios),
            ],
          ),
        ),
        Container(
          height: 100.0,
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
