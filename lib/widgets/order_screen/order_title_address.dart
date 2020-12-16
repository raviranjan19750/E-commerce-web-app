import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:living_desire/data/data.dart';
import 'package:super_tooltip/super_tooltip.dart';
import '../../models/models.dart';

class OrderTitleAddress extends StatefulWidget {
  final String name;
  final String address;
  final String pincode;
  final String phone;

  const OrderTitleAddress({
    Key key,
    this.address,
    this.name,
    this.phone,
    this.pincode,
  }) : super(key: key);

  @override
  _OrderTitleAddressState createState() => _OrderTitleAddressState();
}

class _OrderTitleAddressState extends State<OrderTitleAddress> {
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      child: Text(widget.name),
      preferBelow: true,
      message: widget.name + '\n' + widget.address + '\n' + widget.phone,
      textStyle: TextStyle(
        color: Colors.black,
        fontSize: 12,
      ),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.orange[300],
        ),
      ),
    );
  }
}
