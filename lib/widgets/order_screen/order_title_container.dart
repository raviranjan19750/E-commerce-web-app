import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../config/configs.dart';
import '../widgets.dart';
import 'package:intl/intl.dart';

class OrderTitleContainer extends StatelessWidget {
  final Order order;

  const OrderTitleContainer({
    Key key,
    this.order,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          right: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    right: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.placedOn,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      Text(formatter.format(order.placedDate).toString()),
                    ],
                  ),
                ),
                // Total Proce of Order
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.total,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      // Ordered Product Price total
                      Text(Strings.rupeesSymbol + order.amount.toString()),
                    ],
                  ),
                ),
                // Address Delivery
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.shipTo,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),

                      // Delivery Address Pop up
                      OrderTitleAddress(
                        name: order.name,
                        address: order.address,
                        phone: order.phone,
                        pincode: order.pincode,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.deliveryStatus,
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),
                      // Delivery Status Pop up
                      OrderTitleDeliveryStatus(
                        status: order.status,
                        tracking: order.tracking,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            Strings.orderID,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          Text(order.orderID),
                        ],
                      ),
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
