// Dummy Data later from firebase
import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/models.dart';

final List<ProductType> productsType = [
  ProductType(type: 'Product 1'),
  ProductType(type: 'Product 2'),
  ProductType(type: 'Product 3'),
  ProductType(type: 'Product 4'),
  ProductType(type: 'Product 5'),
];

final List<Product> product = [
  Product(name: 'Product Item 1', currentPrice:  2000, previousPrice:  1500, discount: 36),
  Product(name: 'Product Item 2', currentPrice:  2000, previousPrice:  1500, discount: 36),
  Product(name: 'Product Item 3', currentPrice:  2000, previousPrice:  1500, discount: 36),
  Product(name: 'Product Item 4', currentPrice:  2000, previousPrice:  1500, discount: 36),
  Product(name: 'Product Item 5', currentPrice:  2000, previousPrice:  1500, discount: 36),
  Product(name: 'Product Item 6', currentPrice:  2000, previousPrice:  1500, discount: 36),

];

final List<Color> itemColors = [
  Colors.blue,
  Colors.green,
  Colors.brown,
  Colors.yellow,
  Colors.red

];


final List<String> productItemDescriptions = [
  "Pack Contents – 1 Bean Bag Cover without beans",
  "Fade resistant Leatherette fabric with superior seam and tear strength",
  "Double stitched for extra strength",
  "Product Dimensions: Length (127 cm)",
  "Width (127 cm)",
  "Height (117 cm)",

];
