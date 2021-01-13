import 'package:flutter/material.dart';
import 'package:living_desire/models/StringToHexColor.dart';


class OrderedProduct {
  final String key;
  final String productName;
  final String productID;
  final String variantID;
  final double sellingPrice;
  final String imageUrl;
  final List<Color> colour;
  var color;
  final String size;
  final double discountPrice;
  final double quantity;
  //Rating rating;
  double rating;
  String review;
  String ratingID;

  OrderedProduct({
    this.key,
    this.review,
    this.ratingID,
    this.rating,
    this.productName,
    this.imageUrl,
    this.colour,
    this.size,
    this.color,
    @required this.productID,
    @required this.variantID,
    @required this.sellingPrice,
    @required this.discountPrice,
    @required this.quantity,
  });

  factory OrderedProduct.fromJson(dynamic data) {
    if (data == null) return null;

    List<Color> getColors(List<dynamic> data){

      List<Color> temp = new List();

      for(int i=0;i<data.length;i++){
        String hexColor = data[i]['hexCode'];
        Color color = HexColor.hexToColor(hexColor);
        temp.add(color);
      }

      return temp;

    }

    return OrderedProduct(
      productID: data['productID'],
      variantID: data['variantID'],
      sellingPrice: data['sellingPrice'],
      discountPrice: data['discountPrice'],
      quantity: data['quantity'],
      rating: data['rating'],
      review: data['review'],
      ratingID: data['ratingID'],
      colour: getColors(data['colour']),
      size: data['size'],
      imageUrl: data['productImage'],
      productName: data['productName'],
    );
  }
}
