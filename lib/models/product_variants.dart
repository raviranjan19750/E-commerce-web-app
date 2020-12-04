/**
 *  class for individual product item
 */

class ProductVariants {
  final double manufacturingPrice;
  final double sellingPrice;
  final double discountPrice;

  final String size;
  final String colour;
  final String productID;
  final String variantID;

  final bool isAvailable;

  final List<String> images;

  ProductVariants({
    this.manufacturingPrice,
    this.sellingPrice,
    this.discountPrice,
    this.size,
    this.colour,
    this.productID,
    this.variantID,
    this.isAvailable,
    this.images
  });
}
