import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductQuantityCount extends StatefulWidget {
  @override
  _ProductQuantityCountState createState() => _ProductQuantityCountState();
}

class _ProductQuantityCountState extends State<ProductQuantityCount> {


  int itemQuantityCount = 0;

  int incrementItemQuantity(int count ) {
    return ++count;
  }

  int decrementItemQuantity(int count ) {

    if(count <=0) {
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
          padding: EdgeInsets.symmetric(
              horizontal: 8.0, vertical: 0.0),
          child: Text(
            itemQuantityCount.toString(),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black),
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
