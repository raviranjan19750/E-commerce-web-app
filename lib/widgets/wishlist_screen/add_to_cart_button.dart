import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/wishlist/wishlist_bloc.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/service/navigation_service.dart';

class AddToCartButton extends StatefulWidget {
  final String productID;
  final String variantID;
  final authID;
  final String documentID;

  const AddToCartButton({
    this.documentID,
    this.productID,
    this.authID,
    this.variantID,
  });
  @override
  _AddToCartButtonState createState() => _AddToCartButtonState();
}

class _AddToCartButtonState extends State<AddToCartButton> {
  Widget _buildWidget() {
    return InkWell(
      onTap: () {
        BlocProvider.of<CartBloc>(context).add(AddCart(
          authID: widget.authID,
          productID: widget.productID,
          variantID: widget.variantID,
          quantity: 1,
        ));
        BlocProvider.of<WishlistBloc>(context).add(DeleteWishlist(
          authID: widget.authID,
          productID: widget.productID,
          key: widget.documentID,
        ));

        locator<NavigationService>().navigateTo(RoutesConfiguration.CART);
        // BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        //   if (state is CartDetailLoading) {
        //     return CircularProgressIndicator();
        //   } else if (state is CartDetailLoadingSuccessful) {
        //     return SnackBar(
        //       content: Text('Item added to cart'),
        //     );
        //   }
        // });
      },
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width * 0.15,
        color: Colors.white.withAlpha(180),
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(vertical: 6),
        child: Icon(Icons.add_shopping_cart),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }
}
