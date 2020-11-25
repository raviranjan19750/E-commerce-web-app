import 'package:flutter/material.dart';
import '../../models/models.dart';

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
        top: 4.0,
        bottom: 4.0,
      ),
      // TODO: Expandable widget
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            // Image of the Ordered Product
            Container(
              width: 180,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
              ),
              child: Container(
                child: Row(
                  children: [
                    Text('${widget.order.orderedProducts.length}'),
                    Text(widget.order.orderID),
                    Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              // Ordered Products Total Cost Price
                              //Text(widget.order.orderedProducts)
                              // Ordered Product Selling Price: Price at which usder bought the item
                              //Text(widget.order.orderedProducts)
                              // Discounted Amount
                              //Text('You saved ₹ ${widget.order.orderedProducts.sellingPrice-widget.order.orderedProducts.costPrice}')
                              Container(
                                child: Row(
                                  children: [
                                    //Colour Of the Product
                                    // CircleAvatar(
                                    //   backgroundColor: widget.order.orderedProducts.colour,
                                    // ),
                                    // Size of the product
                                    //Text('Size:'+widget.order.orderedProducts.size),
                                    // Quantity of the Ordered Products
                                    //Text('Quantity:', + widget.order.orderedProducts.quantity)
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    // View More Button to show Expande ordered Product list
                                    RaisedButton(
                                      child: Text('View More'),
                                      onPressed: () {},
                                    ),
                                    // Need Help Support
                                    Text('Need Help'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text('Placed On:' + widget.order.datePlaced),
                              SizedBox(
                                height: 4,
                              ),
                              // Address of the Order
                              //Text('Delivery Address:'+widget.order.address),
                              SizedBox(
                                height: 4,
                              ),
                              // Phone Number of the User/Client
                              //Text('Phone Number:'+widget.order.phoneNumber),
                              Container(
                                child: Column(
                                  children: [
                                    //TODO: Tracking Status
                                    //TODO: Rate and Review
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
