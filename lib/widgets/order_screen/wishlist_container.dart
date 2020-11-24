import 'package:flutter/material.dart';
import '../../data/data.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

class WishlistContainer extends StatelessWidget {
  // WishList Container
  final List<Product> wishlistProducts = product;
  @override
  Widget build(BuildContext context) {
    return Container(
      // Grid View to display different Products
      child: GridView.builder(
        itemCount: wishlistProducts.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          // Display a product Item
          return ProductItem(product: wishlistProducts[index]);
        },
      ),
    );
  }
}
