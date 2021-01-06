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

final List<Order> orders = [
  Order(
    address: 'ndkdnalm',
    amount: 2345,
    name: 'sdooadsno',
    orderID: 'sdbadbian13rvs',
    phone: '74992793129',
    pincode: '123455',
    placedDate: DateTime.now(),
    deliveryDate: DateTime.now(),
    expectedDeliveryDate: DateTime.now(),
    status: 101,
    statusValue: 'Order Placed',
    tracking: [
      Tracking(
        comments: 'vinso',
        date: DateTime.now(),
        status: 101,
      ),
    ],
    orderedProducts: [
      OrderedProduct(
          productID: 'dvsnkadnkn',
          variantID: 'vdsnknvdskn',
          sellingPrice: 12334,
          discountPrice: 23455,
          quantity: 2,
          colour: [
            Color(0xFF4BCB1F),
          ],
          productName: 'nvknadknvsnsnv',
          rating: 4,
          ratingID: 'cknknanas',
          review: 'dkabikadvbnona',
          size: 'M',
          imageUrl:
              'https://www.google.co.in/url?sa=i&url=https%3A%2F%2Fwww.gettyimages.com%2Fcollections%2F500px&psig=AOvVaw1GF1dBxK_9x_KN-Utubbgq&ust=1609754326265000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCIDfw6nA_-0CFQAAAAAdAAAAABAJ'),
    ],
  ),
];

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
