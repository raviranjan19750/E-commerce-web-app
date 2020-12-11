class CustomCart{

  final String authID,productType,productSubType,size,colour,productID,variantID,description;

  final int quantity;

  final DateTime dateAdded,dateUpdated;

  final List<String> images;

  CustomCart({
      this.authID,
      this.productType,
      this.productSubType,
      this.size,
      this.colour,
      this.productID,
      this.variantID,
      this.description,
      this.quantity,
      this.dateAdded,
      this.dateUpdated,
      this.images});
}