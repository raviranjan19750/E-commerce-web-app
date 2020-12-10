class Wishlist {
  final String key;
  final String productID;
  final String variantID;
  final DateTime dateAdded;
  final String imageUrl;
  final double sellingPrice;
  final double discountPrice;
  final String name;

  Wishlist({
    this.key,
    this.productID,
    this.variantID,
    this.dateAdded,
    this.imageUrl,
    this.discountPrice,
    this.name,
    this.sellingPrice,
  });
  factory Wishlist.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print(data.toString());
    var wishlist = {
      'key': data['id'],
      'productID': data['data']['productID'],
      'variantID': data['data']['variantID'],
      'imageUrl': data['data']['imageUrl'],
      'discountPrice': data['data']['discountPrice'],
      'name': data['data']['name'],
      'sellingPrice': data['data']['sellingPrice'],
    };
    print(wishlist.toString());
    return Wishlist(
      key: data['id'],
      productID: data['data']['productID'],
      variantID: data['data']['variantID'],
      imageUrl: data['data']['imageURL'],
      discountPrice: data['data']['discountPrice'],
      name: data['data']['name'],
      sellingPrice: data['data']['sellingPrice'],
    );
  }
}
