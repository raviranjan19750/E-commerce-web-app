import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../data/data.dart';
import '../widgets.dart';

class NormalOrdersContainer extends StatelessWidget {
  // Normal Order Container
  @override
  Widget build(BuildContext context) {
    final List<Order> orders = order;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children: [
            //
            ...orders.map(
              (orderItem) => OrderItem(
                order: orderItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
