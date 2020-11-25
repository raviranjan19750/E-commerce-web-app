import 'package:flutter/material.dart';
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
            Container(
              color: Colors.pink,
              width: 120,
              child: Text(' product Image'),
            ),
            Expanded(
              child: ExpandableNotifier(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                                  Text('Order ID:' + widget.order.orderID),
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
                                        Text(
                                            'Quantity: ${widget.order.orderedProducts.length}'),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: [
                                        FlatButton(
                                          child: Text('View More'),
                                          onPressed: () {},
                                        ),
                                        FlatButton(
                                          child: Text('Need Help?'),
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
                                  Text('Placed On:' + widget.order.datePlaced),
                                  Text('Delivery Address:' +
                                      widget.order.contactInformation.name +
                                      widget.order.contactInformation
                                          .addressLine),
                                  //Phone Number
                                  Text('Phone Number' +
                                      widget.order.contactInformation.phone),
                                  Container(
                                    child: Row(
                                      children: [
                                        // Tracking Bar
                                        // TrackingStatusBar(),
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
      // child: Container(
      //   width: double.infinity,
      //   child: Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Container(
      //         color: Colors.pink,
      //         width: 120,
      //         height: double.infinity,
      //         child: Text(' product Image'),
      //       ),
      // Container(
      //   child: Row(
      //     children: [
      //       // Product Name
      //       Text(widget.order.orderedProducts[0].productId),
      //     ],
      //   ),
      // ),
      //     ],
      //   ),
      // ),
      // // TODO: Expandable widget
      // child: Container(
      //   color: Colors.red,
      //   width: double.infinity,
      // child: Row(
      //   children: [
      // Image of the Ordered Product
      // Container(
      //   color: Colors.red,
      //   width: 180,
      // ),
      // Padding(
      //   padding: const EdgeInsets.only(
      //     left: 20.0,
      //   ),
      //   child: Container(
      //     child: Row(
      //       children: [
      //         Text('${widget.order.orderedProducts.length}'),
      //         Text(widget.order.orderID),
      //         Column(
      //           children: [
      //             Container(
      //               child: Row(
      //                 children: [
      //                   // Ordered Products Total Cost Price
      //                   //Text(widget.order.orderedProducts)
      //                   // Ordered Product Selling Price: Price at which usder bought the item
      //                   //Text(widget.order.orderedProducts)
      //                   // Discounted Amount
      //                   //Text('You saved ₹ ${widget.order.orderedProducts.sellingPrice-widget.order.orderedProducts.costPrice}')
      //                   Container(
      //                     child: Row(
      //                       children: [
      //                         //Colour Of the Product
      //                         // CircleAvatar(
      //                         //   backgroundColor: widget.order.orderedProducts.colour,
      //                         // ),
      //                         // Size of the product
      //                         //Text('Size:'+widget.order.orderedProducts.size),
      //                         // Quantity of the Ordered Products
      //                         //Text('Quantity:', + widget.order.orderedProducts.quantity)
      //                       ],
      //                     ),
      //                   ),
      //                   Container(
      //                     child: Row(
      //                       children: [
      //                         // View More Button to show Expande ordered Product list
      //                         RaisedButton(
      //                           child: Text('View More'),
      //                           onPressed: () {},
      //                         ),
      //                         // Need Help Support
      //                         Text('Need Help'),
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //             Divider(
      //               color: Colors.black,
      //               thickness: 2,
      //             ),
      //             Container(
      //               child: Row(
      //                 children: [
      //                   Text('Placed On:' + widget.order.datePlaced),
      //                   SizedBox(
      //                     height: 4,
      //                   ),
      //                   // Address of the Order
      //                   //Text('Delivery Address:'+widget.order.address),
      //                   SizedBox(
      //                     height: 4,
      //                   ),
      //                   // Phone Number of the User/Client
      //                   //Text('Phone Number:'+widget.order.phoneNumber),
      //                   Container(
      //                     child: Column(
      //                       children: [
      //                         //TODO: Tracking Status
      //                         //TODO: Rate and Review
      //                       ],
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ],
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      //   ],
      // ),
      //   ),
    );
  }
}
