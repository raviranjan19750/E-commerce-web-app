import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/wishlist/wishlist_bloc.dart';
import '../../data/data.dart';
import '../../models/models.dart';
import '../widgets.dart';

class WishlistContainer extends StatelessWidget {
  // WishList Container
  final List<Product> wishlistProducts = product;
  @override
  Widget build(BuildContext context) {
    print('Wishlist Container');
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        if (state is WishlistDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is WishlistDetailLoadingSuccessful) {
          return Container(
            // Grid View to display different Products
            child: Wrap(
              children: [
                ...state.wishlist.map(
                  (e) => WishlistProductItem(
                    product: e,
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
