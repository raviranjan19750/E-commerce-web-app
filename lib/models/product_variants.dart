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


  static ProductVariants fromMap(Map <String, dynamic> data) {

    if(data == null) return null;

    return ProductVariants(
      manufacturingPrice: data['manufacturingPrice'],
      sellingPrice: data['sellingPrice'],
      discountPrice: data['discountPrice'],
      size: data['size'],
      colour: data['colour'],
      productID: data['productID'],
      variantID: data['variantID'],
      isAvailable: data['isAvailable'],
      images: data['images'].cast<String>(),

    );

  }



}
