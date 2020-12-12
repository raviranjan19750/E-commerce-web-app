

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_web_image_picker/flutter_web_image_picker.dart';

class BulkOrderProvider with ChangeNotifier{

  double elevation = 4;
  double size = 1;

  bool stepOneDone = false;

  bool stepTwoDone = false;


  bool productTypeSelected = false;

  bool productSubTypeSelected = false;

  int selectedType = -1;
  int selectedSubType = -1;

  List<Image> logos = new List<Image>();

  void initStepOne(String productType, String productSubType){

    if(productType == null || productType.isEmpty){

      stepOneDone = false;
    }
    else{

      stepOneDone = true;

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

}