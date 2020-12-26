
import 'dart:collection';
import 'dart:convert';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:http/http.dart' as http;

class BulkOrderProvider with ChangeNotifier{

  double elevation = 4;
  double size = 1;

  bool stepOneDone = false;

  bool stepTwoDone = false;

  TextEditingController quantityController = new TextEditingController(text: '50');

  bool productTypeSelected = false;

  bool productSubTypeSelected = false;

  int selectedType = -1;
  int selectedSubType = -1;

  String itemSize = "S";

  String description  = "";

  List<Image> logos = new List<Image>();

  int quantity = 50;

  BulkOrderCart bulkOrderCart = new BulkOrderCart();

  HashMap<String,List<String>> productTypeMap = new HashMap<String,List<String>>();
  
  List<String> subTypes = new List<String>();

  void onItemSizeChanged(String s){

    itemSize = s;
    bulkOrderCart.size = s;
    notifyListeners();

  }

  void initStepOne(String productType, String productSubType) async {

    SearchApi searchApi = new SearchApi();

    List<FilterTag> list = await searchApi.getProductTypeAndSubtype();

    for(FilterTag f in list){

      for(FilterCategoryChild c in f.filterChilds){

        List<FilterTag> list = await searchApi.getSubTypes(c.filterID);

        for(FilterTag f1 in list){

          List<String> subTypes = new List<String>();

          for(FilterCategoryChild c1 in f1.filterChilds){

            subTypes.add(c1.filterID);

          }

          productTypeMap.putIfAbsent(c.filterID, () => subTypes);

        }

      }
    }

    if(productType == null || productType.isEmpty){

      stepOneDone = false;
    }
    else{

      stepOneDone = true;

      bulkOrderCart.productID = productType;
      bulkOrderCart.variantID = productSubType;

    }

    notifyListeners();

  }

  void onProductTypeSelected(int index){

    productTypeSelected = true;
    selectedType = index;
    bulkOrderCart.productID = productTypeMap.keys.elementAt(index);
    selectedSubType = -1;
    productSubTypeSelected = false;
    subTypes = productTypeMap.values.elementAt(index);
    notifyListeners();

  }

  void onProductSubTypeSelected(int index){

    productSubTypeSelected = true;
    selectedSubType = index;
    bulkOrderCart.variantID = subTypes.elementAt(index);
    notifyListeners();

  }

  void onEnter(){
      elevation = 20;
      size = 1.1;

      notifyListeners();
  }

  void onExit(){

    elevation = 4;
    size = 1;

    notifyListeners();

  }

  void getImage() async {

    final Image image = await FlutterWebImagePicker.getImage;

    logos.add(image);

    notifyListeners();
  }

  void deleteImage(int index){

    logos.removeAt(index);

    notifyListeners();

  }

  void onStepOneDone(){

      stepOneDone = true;

      notifyListeners();

  }

  void onStepTwoDone(){

      stepTwoDone = true;
      notifyListeners();

  }

  void onStepOneReverse(){
      stepOneDone = false;
      notifyListeners();
  }

  void incrementQuantity(int val){

    quantity++;
    bulkOrderCart.quantity = quantity;
    quantityController.text = quantity.toString();
    notifyListeners();

  }

  void decrementQuantity(int val){

    quantity--;
    bulkOrderCart.quantity = quantity;
    quantityController.text = quantity.toString();
    notifyListeners();

  }

  void addToCart() async{

    bulkOrderCart.description = description;

    print("Product ID : " + bulkOrderCart.productID);
    print("Variant ID : " + bulkOrderCart.variantID);
    print("Size : " + bulkOrderCart.size);
    print("Quantity : " + bulkOrderCart.quantity.toString());
    print("Description : " + description);

    // Upload Images to fireStore
    // add data to cart

    await addCustomCart("kisdjsjdnjsdhn81237Q");


  }


  Future<void> addCustomCart(String authID) async {
    try {

      var data = {

        "authID": authID,
        "productType": bulkOrderCart.productID,
        "quantity": bulkOrderCart.quantity,
        "size": bulkOrderCart.size,
        "colour": bulkOrderCart.colour,
        "productID": bulkOrderCart.productID,
        "variantID": bulkOrderCart.variantID,
        "description": bulkOrderCart.description,

      };

      final response =
      await http.post(FunctionConfig.host + 'custom/{$authID}',
          body: jsonEncode(data)
      );
      if (response.statusCode == 200) {

          print("Success");

      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }



}

  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child('testingImages');
    UploadTask uploadTask = storageReference.putFile(null);
    await uploadTask;

    storageReference.getDownloadURL().then((fileURL) {



    });
  }

  void onClear(){

    selectedType = -1;
    selectedSubType = -1;
    quantity = 50;
    quantityController.text = quantity.toString();
    stepTwoDone = false;
    stepOneDone = false;
    productTypeSelected = false;
    productSubTypeSelected = false;
    notifyListeners();

  }

}