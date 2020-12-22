class Product {
  // Model For Product
  final String title;
  final List<String> imageUrls;
  final double discountPrice;
  final double retailPrice;
  final String size;
  final List<String> color;
  final String productId;
  final String varientId;
  final Set<String> tags;
  final String type;
  final String subType;
  final bool isAvailable;

  Product(
      {this.title,
      this.imageUrls,
      this.discountPrice,
      this.retailPrice,
      this.size,
      this.color,
      this.productId,
      this.varientId,
      this.tags,
      this.type,
      this.subType,
      this.isAvailable});
}
