import 'package:clippy_flutter/clippy_flutter.dart';
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
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        right: 16.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),

            child: Text(
              Strings.deliveringTo,
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 14,
              ),
            ),
            // Get Pincode
          ),

          Divider(
            thickness: 0.5,
            color: Colors.black54,
          ),
          Diagonal(
            axis: Axis.vertical,
            position: DiagonalPosition.TOP_RIGHT,
            clipHeight: MediaQuery.of(context).size.height * 0.03,
            child: Container(
              color: Colors.red[900],
              width: MediaQuery.of(context).size.width * 0.065,
              height: MediaQuery.of(context).size.height * 0.03,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10.0,
                  ),
                  child: carts.length > 1
                      ? Text(
                          carts.length.toString() + ' ' + Strings.items,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          carts.length.toString() + ' ' + Strings.item,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                ),
              ),
            ),
          ),
          // Cart Items
          ...carts.map(
            (e) => CartItemView(
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
      ),
    );
  }
}
