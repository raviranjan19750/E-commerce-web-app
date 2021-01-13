import 'package:living_desire/models/productVariantColorModel.dart';

class ComboProduct {
  // Model For ComboProduct
  final String title;
  final List<String> imageUrls;
  final List<String> descriptions;
  final List<Variant> productVariant;

  final double discountPrice;
  final double retailPrice;
  final String productId;
  final bool isAvailable;
  final bool isInCart;
  final bool isInWishlist;

  ComboProduct(
      {this.title,
      this.imageUrls,
      this.descriptions,
      this.discountPrice,
      this.retailPrice,
      this.productId,
      this.productVariant,
      this.isAvailable,
      this.isInCart,
      this.isInWishlist});
}

class Variant {
  Variant({
    this.variantId,
    this.size,
    this.colour,
    this.type,
    this.subType,
  });

  String variantId;
  String size;
  List<ProductVariantColor> colour;
  String type;
  String subType;

  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
        variantId: json["variantID"],
        size: json["size"],
        colour: List<ProductVariantColor>.from(
            json["colour"].map((x) => ProductVariantColor.fromJson(x))),
        type: json["type"],
        subType: json["subType"],
      );
}
