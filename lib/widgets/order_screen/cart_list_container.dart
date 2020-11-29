import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../config/configs.dart';
import '../widgets.dart';

class CartListContainer extends StatelessWidget {
  final List<Cart> carts;

  const CartListContainer({
    Key key,
    this.carts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Cart List Container');
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.deliveringTo),
          ...carts.map(
            (e) => CartItem(
              cart: e,
            ),
          ),
          // Container(
          //   child: Expanded(
          //     child: Column(
          //       children: [
          //         ...carts.map(
          //           (e) => CartItem(
          //             cart: e,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
    );
  }
}
