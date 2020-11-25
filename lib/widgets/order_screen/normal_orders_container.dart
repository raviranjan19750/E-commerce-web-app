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
        color: Colors.black12,
        width: double.infinity,
        height: double.infinity,
        child: ListView.builder(
          itemCount: orders.length,
          itemBuilder: (context, index) {
            return OrderItem(
              order: orders[index],
            );
          },
        ),

        // child: Row(
        //   children: [
        //     const Divider(
        //       color: Colors.black,
        //       height: 10,
        //     ),
        //     Padding(
        //       padding: const EdgeInsets.only(
        //         top: 10.0,
        //         bottom: 10.0,
        //       ),
        //       child: ListView.builder(
        //         itemCount: orders.length,
        //         itemBuilder: (context, index) {
        //           return Text(orders[index].orderID);
        //           // return OrderItem(
        //           //   order: orders[index],
        //           // );
        //         },
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
