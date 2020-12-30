import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/home_screen_products/product_item.dart';

class CartDetail {}

class Cart {
  String key;
  DateTime dateAdded;
  String variantID;
  String productID;
  String productType;
  int quantity;
  double manufacturingPrice;
  double discountPrice;
  bool isAvailable;
  double sellingPrice;
  String name;
  String pincode;
  String imageUrl;
  List<Color> colour;
  String size;
  bool isCombo;

  Cart({
    this.key,
    this.dateAdded,
    this.productType,
    this.discountPrice,
    this.pincode,
    this.sellingPrice,
    this.isAvailable,
    this.manufacturingPrice,
    this.productID,
    this.variantID,
    this.quantity,
    this.colour,
    this.imageUrl,
    this.isCombo = false,
    this.name,
    this.size,
  });

  factory Cart.fromJson(dynamic data) {
    if (data == null) return null;

    return Cart(
      key: data['id'],
      //pincode: data['pincode'],
      name: data['data']['productName'] == null
          ? null
          : data['data']['productName'],
      // colour: data['data']['colour'],
      // colour:
      //     (data['data']['colour'] as List<dynamic>).map((e) {
      //   return Colour.fromJson(e);
      // }).toList(),
      colour: data['data']['colour'] == null
          ? null
          : GetColors.fromHex((data['data']['colour'] as List)
              .map((e) => (e as String))
              .toList()),
      // //dateAdded: data['data']['dateAdded'],
      manufacturingPrice: data['data']['manufacturingPrice'] == null
          ? null
          : data['data']['manufacturingPrice'],
      imageUrl:
          data['data']['images'] == null ? null : data['data']['images'][0],
      discountPrice: data['data']['discountPrice'] == null
          ? null
          : data['data']['discountPrice'],
      sellingPrice: data['data']['sellingPrice'] == null
          ? null
          : data['data']['sellingPrice'],
      //isCombo: data['data']['isCombo'],
      isAvailable: data['data']['isAvailable'] == null
          ? null
          : data['data']['isAvailable'],
      productID:
          data['data']['productID'] == null ? null : data['data']['productID'],
      variantID:
          data['data']['variantID'] == null ? null : data['data']['variantID'],
      quantity:
          data['data']['quantity'] == null ? null : data['data']['quantity'],
      productType: data['data']['productType'] == null
          ? null
          : data['data']['productType'],
      size: data['data']['size'] == null ? null : data['data']['size'],
    );
  }
}
