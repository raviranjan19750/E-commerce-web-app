import 'package:flutter/material.dart';
import 'package:living_desire/bloc/cart/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartItemCount extends StatefulWidget {
  final int quantity;
  final String documentID;

  const CartItemCount({
    Key key,
    this.documentID,
    this.quantity,
  }) : super(key: key);
  @override
  _CartItemCountState createState() => _CartItemCountState();
}

class _CartItemCountState extends State<CartItemCount> {
  int itemQuantityCount;

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
  void initState() {
    // TODO: implement initState
    super.initState();
    itemQuantityCount = widget.quantity;
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
              BlocProvider.of<CartBloc>(context).add(ChangeQuantityCart(
                widget.documentID,
                itemQuantityCount,
                "id1",
              ));
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
              BlocProvider.of<CartBloc>(context).add(ChangeQuantityCart(
                widget.documentID,
                itemQuantityCount,
                "id1",
              ));
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
