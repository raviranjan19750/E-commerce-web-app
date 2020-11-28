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
      child: Expanded(
        child: GridView.builder(
          itemCount: wishlistProducts.length,
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 5,
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height / 0.3),
          ),
          itemBuilder: (BuildContext context, int index) {
            // Display a product Item
            return WishlistProductItem(product: wishlistProducts[index]);
          },
        ),
      ),
    );
  }
}
