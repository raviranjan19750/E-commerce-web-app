import 'package:flutter/material.dart';

class Cart {
  final DateTime dateAdded;
  final String productID;
  final double quantity;

  Cart({
    this.dateAdded,
    this.productID,
    this.quantity,
  });
}
