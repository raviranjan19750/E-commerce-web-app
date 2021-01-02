class ComboProduct {
  // Model For ComboProduct
  final String title;
  final List<String> imageUrls;
  final List<String> descriptions;
  final double discountPrice;
  final double retailPrice;
  final String productId;
  final bool isAvailable;

  ComboProduct(
      {this.title,
      this.imageUrls,
      this.descriptions,
      this.discountPrice,
      this.retailPrice,
      this.productId,
      this.isAvailable});
}
