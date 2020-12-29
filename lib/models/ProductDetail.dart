import 'dart:convert';

ProductDetail productDetailFromJson(String str) => ProductDetail.fromJson(json.decode(str));

String productDetailToJson(ProductDetail data) => json.encode(data.toJson());

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

  Map<String, dynamic> toJson() => {
    "productID": productId,
    "variantID": variantId,
    "colourOptions": List<dynamic>.from(colourOptions.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
    "sizeOptions": List<dynamic>.from(sizeOptions.map((x) => x)),
    "allVariants": List<dynamic>.from(allVariants.map((x) => x.toJson())),
    "productName": productName,
    "type": type,
    "subType": subType,
    "description": List<dynamic>.from(description.map((x) => x)),
    "isCustomizable": isCustomizable,
    "images": List<dynamic>.from(images.map((x) => x)),
    "size": size,
    "colour": List<dynamic>.from(colour.map((x) => x.toJson())),
    "sellingPrice": sellingPrice,
    "discountPrice": discountPrice,
    "isAvailable": isAvailable,
  };
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

  Map<String, dynamic> toJson() => {
    "variantID": variantId,
    "size": size,
    "colour": List<dynamic>.from(colour.map((x) => x)),
  };
}

class Colour {
  Colour({
    this.name,
    this.hexCode,
  });

  String name;
  String hexCode;

  factory Colour.fromJson(Map<String, dynamic> json) => Colour(
    name: json["name"],
    hexCode: json["hexCode"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "hexCode": hexCode,
  };
}