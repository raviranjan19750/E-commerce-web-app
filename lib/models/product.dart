import 'package:flutter/material.dart';

class Product {
  // Model For Product
  final String name ;
  final int currentPrice ;
  final int previousPrice ;
  final int discount ;

  const Product({
    @required this.name,
    @required this.currentPrice,
    @required this.previousPrice,
    @required this.discount,

  });


}
