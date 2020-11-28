import 'package:flutter/material.dart';

class Product {
  // Model For Product
  final String name;
  final int currentPrice;
  final int previousPrice;
  final int discount;
  final String imageUrl;

  const Product({
    this.imageUrl,
    @required this.name,
    @required this.currentPrice,
    @required this.previousPrice,
    @required this.discount,
  });
}
