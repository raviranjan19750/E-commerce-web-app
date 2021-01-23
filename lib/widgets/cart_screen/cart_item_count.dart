import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';
import 'package:living_desire/bloc/cart_total/cart_total_bloc.dart';

class CartItemCount extends StatelessWidget {
  // Cart Item COunt Container
  final int quantity;

  final String documentID;
  final String productID;

  const CartItemCount({
    Key key,
    this.quantity,
    this.documentID,
    this.productID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var user = BlocProvider.of<AuthenticationBloc>(context).state.user;
    String authID;
    if (user != null) {
      authID = user.uid;
    } else {
      authID = null;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                // Bloc Provider to Change quantity cart
                // Hits API request
                BlocProvider.of<CartItemBloc>(context).add(ChangeQuantityCart(
                  authID: authID,
                  key: documentID,
                  quantity: quantity - 1,
                  productID: productID,
                ));
              },
              child: Icon(
                Icons.remove,
                color: Colors.grey,
                size: 14,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
            child: Text(
              quantity.toString(),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          Container(
            child: InkWell(
              onTap: () {
                // Bloc Provider to Change quantity cart
                // Hits API request
                BlocProvider.of<CartItemBloc>(context).add(ChangeQuantityCart(
                  authID: authID,
                  key: documentID,
                  quantity: quantity + 1,
                  productID: productID,
                ));
              },
              child: Icon(
                Icons.add,
                color: Colors.grey,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
