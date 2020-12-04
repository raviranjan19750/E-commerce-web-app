import 'package:flutter/material.dart';

class Cart {
  final DateTime dateAdded;
  final String variantID;
  final String productID;
  final double quantity;

  Cart({
    this.dateAdded,
    this.productID,
    this.variantID,
    this.quantity,
  });
}
