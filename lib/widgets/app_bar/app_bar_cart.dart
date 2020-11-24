import 'package:flutter/material.dart';

class AppBarCart extends StatelessWidget {
  // App Bar Cart
  // TODO: Change into Stateful widget
  // TODO: Use stack to show no. of items in the cart
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: IconButton(
          icon: Icon(Icons.shopping_cart),
          iconSize: 30.0,
          onPressed: () {},
        ),
      ),
    );
  }
}
