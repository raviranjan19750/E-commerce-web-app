

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';
import 'package:living_desire/models/BulkOrderCart.dart';

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

  List<Image> logos = new List<Image>();

  int quantity = 50;

  BulkOrderCart bulkOrderCart = new BulkOrderCart();

  void onItemSizeChanged(String s){

    itemSize = s;

    notifyListeners();

  }




  void initStepOne(String productType, String productSubType){

    if(productType == null || productType.isEmpty){

      stepOneDone = false;
    }
    else{

      stepOneDone = true;

      bulkOrderCart.productID = productType;
      bulkOrderCart.variantID = productSubType;

    }

  }

  void onProductTypeSelected(int index){

    productTypeSelected = true;
    selectedType = index;
    notifyListeners();

  }

  void onProductSubTypeSelected(int index){

    productSubTypeSelected = true;
    selectedSubType = index;
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
    quantityController.text = quantity.toString();
    notifyListeners();

  }

  void decrementQuantity(int val){

    quantity--;
    quantityController.text = quantity.toString();
    notifyListeners();

  }

}