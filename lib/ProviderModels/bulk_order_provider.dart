

import 'package:flutter/cupertino.dart';

class BulkOrderProvider with ChangeNotifier{

  double elevation = 4;
  double size = 1;

  bool stepOneDone = false;

  bool productTypeSelected = false;

  void initStepOne(String productType, String productSubType){

    if(productType == null || productType.isEmpty){

      stepOneDone = false;
    }
    else{

      stepOneDone = true;

    }

  }

  void onProductTypeSelected(){

    productTypeSelected = true;
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

  void onStepOneDone(){

      stepOneDone = true;
      notifyListeners();

  }

  void onStepOneReverse(){
      stepOneDone = false;
      notifyListeners();
  }

}