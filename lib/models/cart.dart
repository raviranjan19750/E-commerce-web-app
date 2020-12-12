import 'package:flutter/material.dart';

class Cart {
  final String key;
  final DateTime dateAdded;
  final String variantID;
  final String productID;
  final String productType;
  final int quantity;
  final double manufacturingPrice;
  final double discountPrice;
  final bool isAvailable;
  final double sellingPrice;
  final String name;
  final String imageUrl;
  final String colour;
  final String size;
  final bool isCombo;

  Cart({
    this.key,
    this.dateAdded,
    this.productType,
    this.discountPrice,
    this.sellingPrice,
    this.isAvailable,
    this.manufacturingPrice,
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
    var cart = {
      'key': data['id'],
      'name': data['data']['name'],
      'colour': data['data']['colour'],
      'dateAdded': data['data']['dateAdded'],
      'manufacturingPrice': data['data']['manufacturingPrice'],
      'imageUrl': data['data']['images'][0],
      'discountPrice': data['data']['discountPrice'],
      'sellingPrice': data['data']['sellingPrice'],
      'isCombo': data['data']['isCombo'],
      'isAvailable': data['data']['isAvailable'],
      'productID': data['data']['productID'],
      'variantID': data['data']['variantID'],
      'quantity': data['data']['quantity'],
      'productType': data['data']['productType'],
      'size': data['data']['size'],
    };
    print(cart.toString());
    return Cart(
      key: data['id'],
      name: data['data']['productName'],
      colour: data['data']['colour'],
      dateAdded: data['data']['dateAdded'],
      manufacturingPrice: data['data']['manufacturingPrice'],
      imageUrl: data['data']['images'][0],
      discountPrice: data['data']['discountPrice'],
      sellingPrice: data['data']['sellingPrice'],
      isCombo: data['data']['isCombo'],
      isAvailable: data['data']['isAvailable'],
      productID: data['data']['productID'],
      variantID: data['data']['variantID'],
      quantity: data['data']['quantity'],
      productType: data['data']['productType'],
      size: data['data']['size'],
    );
  }
}
