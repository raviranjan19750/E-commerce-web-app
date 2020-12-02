import 'package:flutter/material.dart';
import '../../data/data.dart';
import '../../models/models.dart';
import '../widgets.dart';

class WishlistContainer extends StatelessWidget {
  // WishList Container
  final List<Product> wishlistProducts = product;
  @override
  Widget build(BuildContext context) {
    print('Wishlist Container');
    return Container(
      // Grid View to display different Products
      child: Wrap(
        children: [
          ...wishlistProducts.map(
            (e) => WishlistProductItem(
              product: e,
            ),
          ),
        ],
      ),
      // child: GridView.builder(
      //   itemCount: wishlistProducts.length,
      //   gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 5,
      //     childAspectRatio: MediaQuery.of(context).size.width /
      //         (MediaQuery.of(context).size.height / 0.3),
      //   ),
      //   itemBuilder: (BuildContext context, int index) {
      //     // Display a product Item
      //     return WishlistProductItem(product: wishlistProducts[index]);
      //   },
      // ),
    );
  }
}
