import 'package:flutter/material.dart';

class Cart {
  final String key;
  final DateTime dateAdded;
  final String variantID;
  final String productID;
  final double quantity;
  final String name;
  final String imageUrl;
  final String colour;
  final String size;
  final bool isCombo;

  Cart({
    this.key,
    this.dateAdded,
    this.productID,
    this.variantID,
    this.quantity,
    this.colour,
    this.imageUrl,
    this.isCombo,
    this.name,
    this.size,
  });

  factory Cart.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print(data.toString());

    return Cart(
      key: data['id'],
      name: data['data']['name'],
      colour: data['data']['colour'],
      dateAdded: data['data']['dateAdded'],
      imageUrl: data['data']['imageUrl'],
      isCombo: data['data']['isCombo'],
      productID: data['data']['productID'],
      variantID: data['data']['variantID'],
      quantity: data['data']['quantity'],
      size: data['data']['size'],
    );
  }
}
