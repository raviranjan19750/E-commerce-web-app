import 'dart:convert';

import 'dart:ui';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));



class ProductDetail {
  ProductDetail({
    this.productId,
    this.variantId,
    this.colourOptions,
    this.sizeOptions,
    this.allVariants,
    this.productName,
    this.type,
    this.subType,
    this.description,
    this.isCustomizable,
    this.images,
    this.size,
    this.colour,
    this.sellingPrice,
    this.discountPrice,
    this.isAvailable,
  });

  String productId;
  String variantId;
  List<List<Colour>> colourOptions;
  List<String> sizeOptions;
  List<AllVariant> allVariants;
  String productName;
  String type;
  String subType;
  List<String> description;
  bool isCustomizable;
  List<String> images;
  String size;
  List<Colour> colour;
  int sellingPrice;
  int discountPrice;
  bool isAvailable;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
    productId: json["productID"],
    variantId: json["variantID"],
    colourOptions: List<List<Colour>>.from(json["colourOptions"].map((x) => List<Colour>.from(x.map((x) => Colour.fromJson(x))))),
    sizeOptions: List<String>.from(json["sizeOptions"].map((x) => x)),
    allVariants: List<AllVariant>.from(json["allVariants"].map((x) => AllVariant.fromJson(x))),
    productName: json["productName"],
    type: json["type"],
    subType: json["subType"],
    description: List<String>.from(json["description"].map((x) => x)),
    isCustomizable: json["isCustomizable"],
    images: List<String>.from(json["images"].map((x) => x)),
    size: json["size"],
    colour: List<Colour>.from(json["colour"].map((x) => Colour.fromJson(x))),
    sellingPrice: json["sellingPrice"],
    discountPrice: json["discountPrice"],
    isAvailable: json["isAvailable"],
  );


}

class AllVariant {
  AllVariant({
    this.variantId,
    this.size,
    this.colour,
  });

  String variantId;
  String size;
  List<String> colour;

  factory AllVariant.fromJson(Map<String, dynamic> json) => AllVariant(
    variantId: json["variantID"],
    size: json["size"],
    colour: List<String>.from(json["colour"].map((x) => x)),
  );


}

class Colour {
  Colour({
    this.name,
    this.hexCode,
  });

  Color hexCode;
  String name;

  factory Colour.fromJson(Map<String, dynamic> json) {

    Color fromHex(String hexString) {
      final buffer = StringBuffer();
      if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
      buffer.write(hexString.replaceFirst('#', ''));
      //return Color(int.parse(buffer.toString(), radix: 16));
      return Color(int.parse(
        buffer.toString(),
        radix: 16,
      ));
    }

    return Colour(
      hexCode: fromHex((json['hexCode'] as String)),
      name: json['name'],
    );


  }


}