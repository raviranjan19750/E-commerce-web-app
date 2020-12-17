import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Container(
            child: InkWell(
              onTap: () {
                setState(() {
                  itemQuantityCount = decrementItemQuantity(itemQuantityCount);
                });
                if (itemQuantityCount <= 0) {
                  BlocProvider.of<CartItemBloc>(context).add(DeleteCart(
                    widget.documentID,
                    "id1",
                  ));
                } else {
                  BlocProvider.of<CartItemBloc>(context).add(ChangeQuantityCart(
                    widget.documentID,
                    itemQuantityCount,
                    "id1",
                  ));
                }
              },
              child: Icon(
                Icons.remove,
                color: Colors.grey,
                size: 14,
              ),
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
            child: InkWell(
              onTap: () {
                setState(() {
                  itemQuantityCount = incrementItemQuantity(itemQuantityCount);
                });
                BlocProvider.of<CartItemBloc>(context).add(ChangeQuantityCart(
                  widget.documentID,
                  itemQuantityCount,
                  "id1",
                ));
              },
              child: Icon(
                Icons.add,
                color: Colors.grey,
                size: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
