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
    double total = 0;
    for (int i = 0; i < order.orderedProducts.length; i++) {
      total = total + order.orderedProducts[i].orderPrice;
    }
    return Container(
      child: Expanded(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 25.0,
            right: 25.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(Strings.orderPlaced),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: const NeverScrollableScrollPhysics(),
                    itemCount: order.orderedProducts.length,
                    itemBuilder: (context, index) {
                      return OrderPlacedItem(
                          orderedProduct: order.orderedProducts[index]);
                    },
                  ),
                ),
              ),
              // Total Price of the products
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      Strings.total +
                          '${order.orderedProducts.length}: ₹' +
                          total.toString(),
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
