import 'package:living_desire/config/strings.dart';

// ignore: camel_case_types
class Products {
  final String name;
  final String type;

  final String subType;

  final String productID;

  final List<String> tags;
  final List<String> description;
  final List<String> productIDs;

  final bool isCustomizable;
  final bool isCombo;

  final DateTime addedDate;
  final DateTime updatedDate;

   static const List<String> tag = ["Beans", "Bags"];
   static const List<String> desc = ["Beans description", "Bags description"];
   static const List<String> productIDSList = ["ProductID 1", "ProductID 2"];

  Products(
      {this.name = "RaviRanjan",
      this.type = "Product Type",
      this.subType = "Product sub type",
      this.productID = " productID 123",
      this.tags = tag,
      this.description = desc ,
      this.productIDs = productIDSList,
      this.isCustomizable = true,
      this.isCombo = true,
      this.addedDate ,
      this.updatedDate,
      });
}
