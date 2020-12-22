// Dummy Data later from firebase
import 'dart:ui';

import 'package:flutter/material.dart';

import 'dart:html';

import '../models/models.dart';

final List<ProductType> productsType = [
  ProductType(type: 'Product 1'),
  ProductType(type: 'Product 2'),
  ProductType(type: 'Product 3'),
  ProductType(type: 'Product 4'),
  ProductType(type: 'Product 5'),
];

final List<Product> product = [];

final List<Order> order = [];

final List<Address> address = [];

final List<Cart> cart = [
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
  Cart(
    dateAdded: DateTime(2020, 3, 5, 6),
    productID: 'bsdbls',
    quantity: 20,
  ),
];

final List<Rating> rating = [
  Rating(
    orderID: 'gcholdsvj',
    rating: 4.0,
    reviews: [
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
    ],
  ),
  Rating(
    orderID: 'gcholdsvj',
    rating: 4.0,
    reviews: [
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
    ],
  ),
  Rating(
    orderID: 'gcholdsvj',
    rating: 4.0,
    reviews: [
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
      Review(
        productID: 'nksdvnlns',
        rating: 3.0,
        review: 'bksdbvknl',
      ),
    ],
  ),
];

const List<Color> itemColors = [
  Colors.blue,
  Colors.green,
  Colors.brown,
  Colors.yellow,
  Colors.red
];

const List<String> productItemDescriptions = [
  "Pack Contents – 1 Bean Bag Cover without beans",
  "Fade resistant Leatherette fabric with superior seam and tear strength",
  "Double stitched for extra strength",
  "Product Dimensions: Length (127 cm)",
  "Width (127 cm)",
  "Height (117 cm)",
];
