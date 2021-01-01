import 'package:flutter/material.dart';
import '../widgets.dart';

class CartContainer extends StatelessWidget {
  // Cart Widget

  @override
  Widget build(BuildContext context) {
    //TODO: Get The cart of the same user
    // Match the Product to the Product ID in cart
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.55,
          child: CartListContainer(),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.25,
          child: CartTotalView(),
        ),
      ],
    );
  }
}
