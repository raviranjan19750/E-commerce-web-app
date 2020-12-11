import 'package:flutter/material.dart';
import 'package:living_desire/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/wishlist/wishlist_bloc.dart';

class WishlistProductItem extends StatelessWidget {
  final Wishlist product;

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
                    child: IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        BlocProvider.of<WishlistBloc>(context)
                            .add(DeleteWishlist(
                          authID: "id1",
                          key: product.key,
                        ));
                      },
                    ),
                  ),
                )
              ],
            ),
            Text(product.sellingPrice.toString()),
            Text(
              product.discountPrice.toString(),
            )
          ],
        ),
      ),
    );
  }
}
