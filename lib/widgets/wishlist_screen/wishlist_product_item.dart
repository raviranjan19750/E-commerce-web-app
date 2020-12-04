import 'package:flutter/material.dart';
import 'package:living_desire/models/models.dart';

class WishlistProductItem extends StatelessWidget {
  final Product product;

  const WishlistProductItem({
    Key key,
    this.product,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Wishlist product Item');
    return Container(
      height: 400,
      width: 300,
      child: Card(
        elevation: 2,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  child: Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: Icon(Icons.close),
                  ),
                )
              ],
            ),
            Text(product.retailPrice.toString()),

            Text(
              product.retailPrice.toString(),
            )
          ],
        ),
      ),
    );
  }
}
