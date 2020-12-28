import 'package:cloud_firestore/cloud_firestore.dart';

class BulkOrderCart {

  String  productID, productType,variantID, size, description,key;

  var colour = new List.empty();

  int quantity;

  var images = new List.empty();

  DateTime addedDate,updatedDate;


  BulkOrderCart({
      this.productID,
      this.productType,
      this.variantID,
      this.colour,
      this.size,
      this.description,
      this.key,
      this.quantity,
      this.images,
      this.addedDate,
      this.updatedDate});

  factory BulkOrderCart.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;

    return BulkOrderCart(
      key: data['cartResponseData']['id'],
      addedDate: new Timestamp(
          data['cartResponseData']['data']['addedDate']["_seconds"],
          data['cartResponseData']['data']['addedDate']["_nanoseconds"])
          .toDate(),
      updatedDate: new Timestamp(
          data['cartResponseData']['data']['updatedDate']["_seconds"],
          data['cartResponseData']['data']['updatedDate']["_nanoseconds"])
          .toDate(),
      images: data['cartResponseData']['data']['images'],
      productID: data['cartResponseData']['data']['productID'],
      variantID: data['cartResponseData']['data']['variantID'],
      quantity: data['cartResponseData']['data']['quantity'],
      productType: data['cartResponseData']['data']['productType'],
      size: data['cartResponseData']['data']['size'],
      colour: data['cartResponseData']['data']['colour'],
      description: data['cartResponseData']['data']['description']
    );
  }

  void reset(){

    productID = "";
    variantID = "";
    quantity = 50;
    size = "s";
    description = "";
    key = "";
    images = List.empty();
    productType = "";
    colour = List.empty();

  }

}