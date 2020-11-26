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
                    // width: double.infinity,
                    // height: double.infinity,
                    // child: ListView.builder(
                    //   itemCount: carts.length,
                    //   itemBuilder: (BuildContext context, int index) {
                    //     return Container();
                    //     // return CartItem(
                    //     //   cart: carts[index],
                    //     // );
                    //   },
                    // ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 100,
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
