import 'package:flutter/material.dart';
import '../../config/configs.dart';
import '../../models/models.dart';
import '../widgets.dart';

class OrderPlacedContainer extends StatelessWidget {
  final Order order;
  //Order Placed Container: List of Products
  const OrderPlacedContainer({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Total Product Price
    // double total = 0;
    // for (int i = 0; i < order.orderedProducts.length; i++) {
    //   total = total + order.orderedProducts[i].discountPrice;
    // }
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 25.0,
          right: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              Strings.orderPlaced,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
              ),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: order.orderedProducts.length,
                  itemBuilder: (context, index) {
                    return OrderPlacedItem(
                      orderedProduct: order.orderedProducts[index],
                    );
                  }),
            ),

            // Total Price of the products
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  Strings.total + '(${order.orderedProducts.length} Items): ₹',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
