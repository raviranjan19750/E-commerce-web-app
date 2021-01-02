class QuotationProducts{

  String  productType,productSubType, size;

  var colour = new List.empty();

  int quantity,discountPrice;


  QuotationProducts({
    this.productType,
    this.productSubType,
    this.colour,
    this.size,
    this.quantity,});

  factory QuotationProducts.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;

    return QuotationProducts(
        productSubType: data['productSubType'],
        quantity: data['quantity'],
        productType: data['productType'],
        size: data['size'],
        colour: data['colour'],
    );
  }


}