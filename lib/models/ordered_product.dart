import 'package:flutter/material.dart';

class OrderedProduct {
  final String productID;
  final String variantID;
  final double sellingPrice;
  final double discountPrice;
  final double quantity;

  const OrderedProduct({
    @required this.productID,
    @required this.variantID,
    @required this.sellingPrice,
    @required this.discountPrice,
    @required this.quantity,
  });
}
