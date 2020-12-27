import 'package:convert/convert.dart';

class ProductDetail {
  final String productID;
  final String variantID;
  final String productName;
  final String type;
  final String subType;

  final List<String> sizeOptions;
  final List<String> colourOptions;
  final List<String> images;
  final List<String> description;

  final bool isCustomizable;
  final bool isAvailable;

  final String size;
  final List<String> colour;

  final double sellingPrice;
  final double discountPrice;

  ProductDetail(
      {this.productID,
      this.variantID,
      this.productName,
      this.sizeOptions,
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
      this.subType});

  factory ProductDetail.fromJson(Map<String, dynamic> data) {
    //if(data == null) return null;
    List<String> cols = [];
    for (var col in data["colour"]) {
      var strcol = col['hexCode'] as String;
      cols.add(strcol.replaceAll("#", ""));
    }

    return ProductDetail(
      productID: data["productID"],
      variantID: data["variantID"],
      productName: data["productName"],
      type: data["type"],
      subType: data["subType"],
      size: data["size"],
      colour: cols,
      sellingPrice: data["sellingPrice"],
      discountPrice: data["discountPrice"],
      sizeOptions: data["sizeOptions"].cast<String>(),
      colourOptions: data["colourOptions"].cast<String>(),
      images: data["images"].cast<String>(),
      description: data["description"].cast<String>(),
      isCustomizable: data["isCustomizable"],
      isAvailable: data["isAvailable"],
    );
  }
}
