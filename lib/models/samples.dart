class Samples {

  final String size,productID,variantID,warehouseID,factoryID,productType,productSubtype;

  var color = new List.empty();

  final quantity;

  final double discountPrice;

  Samples({this.size, this.productID, this.variantID, this.warehouseID,
      this.productType, this.productSubtype, this.discountPrice, this.quantity,this.color,this.factoryID});

  factory Samples.fromJson(Map<String,dynamic> data){

    if(data == null)
      return null;

    return Samples(

      color: data['colour'],
      size: data['size'],
      quantity: data['quantity'],
      productType: data['productType'],
      productSubtype: data['productSubType'],
      discountPrice: data['discountPrice'],

    );

  }
}