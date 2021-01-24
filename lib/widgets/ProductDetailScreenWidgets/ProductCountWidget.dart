import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductQuantityCount extends StatefulWidget {
   Function(int) onItemCountChanged;

   ProductQuantityCount({Key key, this.onItemCountChanged}) : super(key: key);
  @override
  _ProductQuantityCountState createState() => _ProductQuantityCountState();
}

class _ProductQuantityCountState extends State<ProductQuantityCount> {


  int itemQuantityCount = 1;

  int incrementItemQuantity(int count ) {
    return ++count;
  }

  int decrementItemQuantity(int count ) {

    if(count <2) {
      return 1;
    }

    return --count;
  }


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        InkWell(
          onTap: () {
            setState(() {
              itemQuantityCount = decrementItemQuantity(itemQuantityCount);
              widget.onItemCountChanged(itemQuantityCount);
            });
          },

          child: Icon(Icons.remove, color: Colors.grey, size: 14),
        ),

        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.0),
          child: Text(
            itemQuantityCount.toString(),
            style: TextStyle(
                fontSize: 14,
                color: Colors.black),
          ),
        ),

        InkWell(

          onTap: () {
            setState(() {
              itemQuantityCount = incrementItemQuantity(itemQuantityCount);
              print(itemQuantityCount);
              widget.onItemCountChanged(itemQuantityCount);
            });
          },

          child: Icon(Icons.add, color: Colors.grey, size: 14),
        ),


      ],
    );
  }
}
