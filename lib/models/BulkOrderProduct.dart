

import 'dart:core';

class BulkOrderProduct{


  final String size,colour,images,description,productType,productSubType,productID,variantID,warehouseID;

  final int quantity,manufacturingPrice,sellingPrice,discountPrice;

  final List<String> imagesUrl;

  BulkOrderProduct({this.size, this.colour, this.images, this.description,
      this.productType, this.productSubType, this.productID, this.variantID,
      this.warehouseID, this.quantity, this.manufacturingPrice,
      this.sellingPrice, this.discountPrice});


}