import 'package:flutter/material.dart';

class CartItemCount extends StatefulWidget {
  final double quantity;

  const CartItemCount({
    Key key,
    this.quantity,
  }) : super(key: key);
  @override
  _CartItemCountState createState() => _CartItemCountState();
}

class _CartItemCountState extends State<CartItemCount> {
  int itemQuantityCount = 0;

  int incrementItemQuantity(int count) {
    return ++count;
  }

  int decrementItemQuantity(int count) {
    if (count <= 0) {
      return 0;
    }

    return --count;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: IconButton(
            onPressed: () {
              setState(() {
                itemQuantityCount = decrementItemQuantity(itemQuantityCount);
              });
            },
            iconSize: 14,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.remove),
            color: Colors.grey,
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: Text(
            itemQuantityCount.toString(),
            style: TextStyle(fontSize: 14, color: Colors.black),
          ),
        ),
        Container(
          child: IconButton(
            onPressed: () {
              setState(() {
                itemQuantityCount = incrementItemQuantity(itemQuantityCount);
              });
            },
            iconSize: 14,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            icon: Icon(Icons.add),
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
