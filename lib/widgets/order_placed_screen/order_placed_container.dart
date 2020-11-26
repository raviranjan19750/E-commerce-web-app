import 'package:flutter/material.dart';
import '../../config/configs.dart';
import '../../models/models.dart';
import '../widgets.dart';

class OrderPlacedContainer extends StatelessWidget {
  final Order order;

  const OrderPlacedContainer({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(Strings.orderPlaced),
          Container(
            child: ListView.builder(
              itemCount: order.orderedProducts.length,
              itemBuilder: (context, index) {
                return OrderPlacedItem(
                    orderedProduct: order.orderedProducts[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
