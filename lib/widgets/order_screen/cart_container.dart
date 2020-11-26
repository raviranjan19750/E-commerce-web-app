import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';
import '../widgets.dart';

class CartContainer extends StatelessWidget {
  // Cart Widget
  @override
  Widget build(BuildContext context) {
    //TODO: Get The cart of the same user
    final List<Cart> carts = cart;
    // Match the Product to the Product ID in cart
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              // width: double.infinity,
              // height: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Strings.deliveringTo),
                  Container(
                    child: Expanded(
                      child: ListView.builder(
                        itemCount: carts.length,
                        itemBuilder: (context, index) {
                          return CartItem(
                            cart: carts[index],
                          );
                        },
                      ),
                    ),
                  ),
                  // Subtotal Container
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(Strings.subTotal + ' (total no. of products)'),
                        Text('Subtotal Amount'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          //TODO: Cart Total
          CartTotal(),
        ],
      ),
    );
  }
}
