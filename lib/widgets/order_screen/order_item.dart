import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';
import 'package:expandable/expandable.dart';
import 'package:rating_bar/rating_bar.dart';

import '../widgets.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({
    Key key,
    this.order,
  }) : super(key: key);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  // Order Item
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Container(
        width: double.infinity,
        child: Card(
          borderOnForeground: false,
          elevation: 2.0,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: Colors.grey,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                OrderTitleContainer(
                  order: widget.order,
                ),
                ...widget.order.orderedProducts.map(
                  (e) => OrderProductItemView(
                    orderID: widget.order.orderID,
                    orderedProduct: e,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
