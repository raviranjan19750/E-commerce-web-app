import 'package:flutter/material.dart';

class OrderedProduct {
  final String productId;
  final double price;
  final double orderPrice;

  const OrderedProduct({
    @required this.productId,
    @required this.price,
    @required this.orderPrice,
  });
}
