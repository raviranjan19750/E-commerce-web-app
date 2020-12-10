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

  String getCartTotal(List<Cart> cart) {}

  @override
  Widget build(BuildContext context) {
    print('Cart List Container');
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              Strings.deliveringTo,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            //TODO: Get Pincode
            Text(
              'Pincode',
              style: TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),
        ...carts.map(
          (e) => CartItem(
            cart: e,
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
    );
  }
}
