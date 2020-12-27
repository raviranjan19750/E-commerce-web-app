import 'package:flutter/material.dart';
import 'package:living_desire/config/get_colors.dart';
import 'package:living_desire/models/models.dart';

class OrderedProduct {
  final String key;
  final String productName;
  final String productID;
  final String variantID;
  final double sellingPrice;
  final String imageUrl;
  final List<Color> colour;
  final String size;
  final double discountPrice;
  final double quantity;
  Rating rating;

  OrderedProduct({
    this.key,
    this.rating,
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
      //rating: Rating.fromJson(data['rating']),
      colour: GetColors.fromHex(
          (data['colour'] as List).map((e) => (e as String)).toList()),
      size: data['size'],
      imageUrl: data['imageURL'],
      productName: data['productName'],
    );
  }
}
