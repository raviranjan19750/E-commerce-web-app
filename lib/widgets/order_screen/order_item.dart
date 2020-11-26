import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';
import 'package:expandable/expandable.dart';
import 'package:rating_bar/rating_bar.dart';

import '../widgets.dart';

class OrderItem extends StatefulWidget {
  final Order order;

  const OrderItem({Key key, this.order}) : super(key: key);

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
        child: Row(
          children: [
            // Product Image
            Container(
              color: Colors.pink,
              width: 120,
              child: Text(' product Image'),
            ),
            Expanded(
              //TODO: Expandable widget
              child: ExpandableNotifier(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Product Name : Get From productID
                      Text(widget.order.orderedProducts[0].productId),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.orderID + widget.order.orderID),
                                  Text(
                                      '${widget.order.orderedProducts[0].orderPrice}'),
                                  Container(
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 8.0,
                                          // Color of the the Product
                                          backgroundColor: Colors.black,
                                        ),
                                        // Size of the product from product id
                                        //Text('Size:'+widget.order.orderedProducts[0].size)
                                        Text(Strings.quantity +
                                            '${widget.order.orderedProducts.length}'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        FlatButton(
                                          child: Text(Strings.viewMore),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          child: Text(Strings.needHelp),
                                          onPressed: () {},
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(Strings.placedOn +
                                      widget.order.datePlaced),
                                  Text(Strings.deliveryAddress +
                                      widget.order.contactInformation.name +
                                      widget.order.contactInformation
                                          .addressLine),
                                  //Phone Number
                                  Text(Strings.phoneNumber +
                                      widget.order.contactInformation.phone),
                                  Container(
                                    child: Row(
                                      children: [
                                        // Tracking Bar
                                        TrackingStatusBar(),
                                        // Rate and Review
                                        RatingContainer(),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
