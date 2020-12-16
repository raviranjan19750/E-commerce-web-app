import 'package:flutter/material.dart';

class OrderedProduct {
  final String key;
  final String productName;
  final String productID;
  final String variantID;
  final double sellingPrice;
  final String imageUrl;
  final String colour;
  final String size;
  final double discountPrice;
  final double quantity;

  const OrderedProduct({
    this.key,
    this.productName,
    this.imageUrl,
    this.colour,
    this.size,
    @required this.productID,
    @required this.variantID,
    @required this.sellingPrice,
    @required this.discountPrice,
    @required this.quantity,
  });

  factory OrderedProduct.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print(data.toString());

    return OrderedProduct(
      key: data['id'],
      productID: data['data']['productID'],
      variantID: data['data']['variantID'],
      sellingPrice: data['data']['sellingPrice'],
      discountPrice: data['data']['discountPrice'],
      quantity: data['data']['quantity'],
      colour: data['data']['colour'],
      size: data['data']['size'],
      imageUrl: data['data']['imageURL'],
      productName: data['data']['productName'],
    );
  }
}
