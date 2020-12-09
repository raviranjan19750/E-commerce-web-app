import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart/cart_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';
import '../widgets.dart';

class CartContainer extends StatelessWidget {
  // Cart Widget
  @override
  Widget build(BuildContext context) {
    print('Cart Container');
    //TODO: Get The cart of the same user

    // Match the Product to the Product ID in cart
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is CartDetailLoadingSuccessful) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CartListContainer(
                    carts: state.cart,
                  ),
                ),
                CartTotal(),
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
