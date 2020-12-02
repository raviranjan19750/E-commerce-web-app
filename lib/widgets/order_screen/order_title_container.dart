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
      height: 50,
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Text('Test'),
            // Placed On Order
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.placedOn,
                ),
                Text(order.placedDate),
              ],
            ),
            // Total Proce of Order
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.total,
                ),
                // Ordered Product Price total
                Text(''),
              ],
            ),
            // Address Delivery
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Strings.shipTo),
                // Delivery Address Pop up
                // OrderTitleAddress(
                //   deliveryAddressID: order.deliveryAddressID,
                // ),
              ],
            ),
            SizedBox(
              width: 250,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Strings.deliveryStatus),
                // Delivery Status Pop up
                OrderTitleDeliveryStatus(
                  status: order.status,
                  tracking: order.tracking,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(Strings.orderID + order.orderID),
                Container(
                  child: InkWell(
                    onTap: () {},
                    child: Text(
                      Strings.invoice,
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
