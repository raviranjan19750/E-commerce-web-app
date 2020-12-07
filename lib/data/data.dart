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

final List<Order> order = [
  Order(
    placedDate: '13121997',
    orderedProducts: [
      OrderedProduct(
        productID: 'dssdbfdg',
        sellingPrice: 456,
        quantity: 2,
        variantID: 'nksdvnl',
        discountPrice: 345,
      ),
    ],
    contactInformation: ContactInformation(
      name: 'Shan',
      addressLine: 'sdjbksolsnl',
      phone: '93886836',
    ),
    expectedDeliveryDate: DateTime(2020, 2, 2, 2),
    deliveryDate: DateTime(2020, 3, 3, 3),
    status: 101,
    tracking: [
      Tracking(
        status: 101,
        date: DateTime(2020, 4, 4, 4),
        comments: 'jbdvsknlsj',
      ),
    ],
    orderID: 'gcholdsvj',
  ),
  Order(
    placedDate: '13121997',
    orderedProducts: [
      OrderedProduct(
        quantity: 10,
        productID: 'dssdbfdg',
        sellingPrice: 456,
        discountPrice: 345,
        variantID: 'bksbkjs',
      ),
    ],
    contactInformation: ContactInformation(
      name: 'Shan',
      addressLine: 'sdjbksolsnl',
      phone: '93886836',
    ),
    expectedDeliveryDate: DateTime(2020, 2, 2, 2),
    deliveryDate: DateTime(2020, 3, 3, 3),
    status: 101,
    tracking: [
      Tracking(
        status: 101,
        date: DateTime(2020, 4, 4, 4),
        comments: 'jbdvsknlsj',
      ),
    ],
    orderID: 'gcholdsvj',
  ),
  Order(
    placedDate: '13121997',
    orderedProducts: [
      OrderedProduct(
        quantity: 20,
        productID: 'dssdbfdg',
        sellingPrice: 456,
        discountPrice: 345,
        variantID: 'bsdlblk',
      ),
    ],
    contactInformation: ContactInformation(
      name: 'Shan',
      addressLine: 'sdjbksolsnl',
      phone: '93886836',
    ),
    expectedDeliveryDate: DateTime(2020, 2, 2, 2),
    deliveryDate: DateTime(2020, 3, 3, 3),
    status: 101,
    tracking: [
      Tracking(
        status: 101,
        date: DateTime(2020, 4, 4, 4),
        comments: 'jbdvsknlsj',
      ),
    ],
    orderID: 'gcholdsvj',
  ),
];

final List<Address> address = [
  Address(
      address: 'nsdkvnldsno', isPrimary: true, name: 'Shan', pincode: '49235'),
  Address(
      address: 'nsdkvnldsno', isPrimary: false, name: 'Shan', pincode: '49235'),
  Address(
      address: 'nsdkvnldsno', isPrimary: false, name: 'Shan', pincode: '49235'),
];

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
