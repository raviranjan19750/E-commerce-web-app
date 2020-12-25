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

  factory OrderedProduct.fromJson(dynamic data) {
    if (data == null) return null;
    print(data.toString());

    return OrderedProduct(
      productID: data['productID'],
      variantID: data['variantID'],
      sellingPrice: data['sellingPrice'],
      discountPrice: data['discountPrice'],
      quantity: data['quantity'],
      //colour: data['data']['colour'],
      size: data['size'],
      imageUrl: data['imageURL'],
      productName: data['productName'],
    );
  }
}
