import 'package:flutter/material.dart';

class Product {
  // Model For Product
  final String title;
  final String imageUrl;
  final double discountPrice;
  final double retailPrice;
  final String size;
  final String color;

  Product({this.title, this.imageUrl, this.discountPrice, this.retailPrice, this.size, this.color});

}
