import 'package:living_desire/config/strings.dart';

// ignore: camel_case_types
class Products {
  final String name;
  final String type;

  final String subType;
  final String productID;
  final String warehouseID ;


  final List<String> tags;
  final List<String> description;


  final bool isCustomizable;
  final bool isCombo;

  final DateTime addedDate;
  final DateTime updatedDate;

  Products(
      {this.name ,
      this.type ,
      this.subType,
      this.productID ,
      this.warehouseID  ,
      this.tags ,
      this.description  ,
      this.isCustomizable ,
      this.isCombo ,
      this.addedDate ,
      this.updatedDate,
      });


  static Products fromMap(Map <String, dynamic> data) {

    if(data == null) return null;

    return Products(
      name: data['name'],
      type: data['type'],
      subType: data['subType'],
      productID: data['productID'],
      warehouseID : data['warehouseID '],
      tags: data['tags'].cast<String>(),
      description: data['description'].cast<String>(),
      isCustomizable: data['isCustomizable'],
      isCombo: data['isCombo'],
      addedDate: data['addedDate'].toDate(),
      updatedDate: data['updatedDate'].toDate(),

    );


  }


}
