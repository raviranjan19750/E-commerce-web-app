import 'dart:ui';

import 'package:living_desire/models/productVariantColorModel.dart';

class ProductDetail {
  final String productID;
  final String variantID;
  final String productName;
  final List<String> sizeOptions;
  final List<List<ProductVariantColor>> colourOptions;
  final List<String> images;
  final List<String> description;
  List<AllVariant> allVariants;
  final bool isCustomizable;
  final bool isAvailable;
  final String size;
  final String type;
  final String subType;
  final List<ProductVariantColor> colour;
  final double sellingPrice;
  final double discountPrice;
  final bool isInCart;
  final bool isInWishlist;

  ProductDetail({
    this.productID,
    this.variantID,
    this.productName,
    this.sizeOptions,
    this.allVariants,
    this.colourOptions,
    this.images,
    this.description,
    this.isCustomizable,
    this.isAvailable,
    this.size,
    this.colour,
    this.sellingPrice,
    this.discountPrice,
    this.type,
    this.subType,
    this.isInCart,
    this.isInWishlist
  });

  factory ProductDetail.fromJson(Map<String, dynamic> data) {
    return ProductDetail(
      productID: data["productID"],
      variantID: data["variantID"],
      productName: data["productName"],
      size: data["size"],
      colour: (data['colour'] as List)
          .map((e) => ProductVariantColor.fromJson(e))
          .toList(),
      sellingPrice: data["sellingPrice"],
      discountPrice: data["discountPrice"],
      sizeOptions: data["sizeOptions"].cast<String>(),
      //colourOptions: colourOption,
      colourOptions: (data['colourOptions'] as List).map((e) {
        return (e as List)
            .map((colourOption) => ProductVariantColor.fromJson(colourOption))
            .toList();
      }).toList(),
      images: data["images"].cast<String>(),
      description: data["description"].cast<String>(),
      allVariants: List<AllVariant>.from(data["allVariants"].map((x) => AllVariant.fromJson(x))),
      isCustomizable: data["isCustomizable"],
      isAvailable: data["isAvailable"],
      type: data["type"],
      subType: data["subType"],
      isInCart: data["isInCart"],
      isInWishlist: data["isInWishlist"],
    );
  }
}

class AllVariant {
  AllVariant({
    this.variantId,
    this.size,
    this.colour,
  });

  String variantId;
  String size;
  List<Color> colour;

  factory AllVariant.fromJson(Map<String, dynamic> json) {
    Color fromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));

      return Color(int.parse(
        buffer.toString(),
        radix: 16,
      ));
    }

    return AllVariant(
      variantId: json["variantID"],
      size: json["size"],
      colour: (json['colour'] as List).map((e) => fromHex(e)).toList(),
    );
  }
}
