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
    //TODO: Get The cart of the same user

    // Match the Product to the Product ID in cart
    return BlocBuilder<CartBloc, CartState>(
      buildWhen: (previous, current) {
        if (current is PrdouctCardViewState) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is CartDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is CartDetailLoadingSuccessful) {
          return Padding(
            padding: const EdgeInsets.only(
              left: 16.0,
              bottom: 16.0,
            ),
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: CartListContainer(
                      carts: state.cart,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: CartTotal(
                      carts: state.cart,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
