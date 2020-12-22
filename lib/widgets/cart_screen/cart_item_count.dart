import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';
import 'package:living_desire/bloc/cart_total/cart_total_bloc.dart';

class CartItemCount extends StatelessWidget {
  final int quantity;
  final String documentID;

  const CartItemCount({Key key, this.quantity, this.documentID}) : super(key: key);

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
                BlocProvider.of<CartItemBloc>(context).add(ChangeQuantityCart(
                  documentID,
                  quantity - 1,
                  "id1",
                ));
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
              quantity.toString(),
              style: TextStyle(fontSize: 14, color: Colors.black),
            ),
          ),
          Container(
            child: InkWell(
              onTap: () {
                BlocProvider.of<CartItemBloc>(context).add(ChangeQuantityCart(
                  documentID,
                  quantity + 1,
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
