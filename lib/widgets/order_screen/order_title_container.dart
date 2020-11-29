import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../config/configs.dart';
import '../widgets.dart';

class OrderTitleContainer extends StatelessWidget {
  final Order order;

  const OrderTitleContainer({
    Key key,
    this.order,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // Placed On Order
          Column(
            children: [
              Text(
                Strings.placedOn,
              ),
              Text(order.placedDate),
            ],
          ),
          // Total Proce of Order
          Column(
            children: [
              Text(
                Strings.total,
              ),
              // Ordered Product Price total
              //Text(''),
            ],
          ),
          // Address Delivery
          Column(
            children: [
              Text(Strings.shipTo),
              OrderTitleAddress(
                deliveryAddressID: order.deliveryAddressID,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
