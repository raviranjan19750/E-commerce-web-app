import 'package:convert/convert.dart';
import 'package:living_desire/models/productVariantColorModel.dart';

class ProductDetail {



  final String productID;
  final String variantID;
  final String productName;

  final List<String> sizeOptions;
  final List<ProductVariantColor> colourOptions;
  final List<String> images;
  final List<String> description;

  final bool isCustomizable;
  final bool isAvailable;

  final String size;
  final List<ProductVariantColor> colour;

  final double sellingPrice;
  final double discountPrice;

  ProductDetail({
    this.productID,
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
    this.discountPrice});

  factory ProductDetail.fromJson(Map<String, dynamic> data) {

    //if(data == null) return null;
    List<ProductVariantColor> cols = [];
    for (var col in data["colour"]) {

      var strcol = col['hexCode'] as String;
      strcol.replaceAll("#", "replace");
      cols.add(new ProductVariantColor(colorHexCode: strcol, colorName: col['name']));

    }

    List<ProductVariantColor> colourOption = [];
    for (var col in data["colourOptions"]) {

      var strcol = col['hexCode'] as String;
      strcol.replaceAll("#", "replace");
      colourOption.add(new ProductVariantColor(colorHexCode: strcol, colorName: col['name']));

    }


    return ProductDetail(
      productID: data["productID"],
      variantID: data["variantID"],
      productName: data["productName"],
      size: data["size"],
      colour: cols,

      sellingPrice: data["sellingPrice"],
      discountPrice: data["discountPrice"],

      sizeOptions: data["sizeOptions"].cast<String>(),
      colourOptions: colourOption,
      images: data["images"].cast<String>(),
      description: data["description"].cast<String>(),

      isCustomizable: data["isCustomizable"],
      isAvailable: data["isAvailable"],

    );

  }
}