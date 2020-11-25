// Dummy Data later from firebase
import 'dart:html';

import '../models/models.dart';

final List<ProductType> productsType = [
  ProductType(type: 'Product 1'),
  ProductType(type: 'Product 2'),
  ProductType(type: 'Product 3'),
  ProductType(type: 'Product 4'),
  ProductType(type: 'Product 5'),
];

final List<Product> product = [
  Product(name: 'Product Item 1'),
  Product(name: 'Product Item 2'),
  Product(name: 'Product Item 3'),
  Product(name: 'Product Item 4'),
  Product(name: 'Product Item 5'),
  Product(name: 'Product Item 6'),
];

final List<Order> order = [];

final List<Address> address = [
  Address(
      addressLine: 'nsdkvnldsno',
      isPrimary: true,
      name: 'Shan',
      pincode: '49235'),
  Address(
      addressLine: 'nsdkvnldsno',
      isPrimary: false,
      name: 'Shan',
      pincode: '49235'),
  Address(
      addressLine: 'nsdkvnldsno',
      isPrimary: false,
      name: 'Shan',
      pincode: '49235'),
];
