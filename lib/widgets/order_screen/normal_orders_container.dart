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
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            ...orders.map(
              (e) => Container(),
              // (e) => OrderItem(
              //   order: e,
              // ),
            ),
          ],
        ),
      ),
      // child: ListView.builder(
      //   itemCount: orders.length,
      //   itemBuilder: (context, index) {
      //     // Order Item
      //     return OrderItem(
      //       order: orders[index],
      //     );
      //   },
      // ),
    );
  }
}
