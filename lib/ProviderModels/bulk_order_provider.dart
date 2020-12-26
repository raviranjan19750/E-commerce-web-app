
import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/cupertino.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/models/uploadImage.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/service/sharedPreferences.dart';

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

  List<UploadImage> logos = new List<UploadImage>();

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

  void startFilePicker() async {

    InputElement uploadInput = FileUploadInputElement()..accept = 'image/*';
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {

        final file = files[0];

        FileReader reader =  FileReader();

        reader.onLoadEnd.listen((e) {


          UploadImage uploadImage = new UploadImage(imageFile: file,uri: reader.result);

          logos.add(uploadImage);
          notifyListeners();


        });

        reader.onError.listen((fileEvent) {

        });

        reader.readAsArrayBuffer(file);
      }
    });
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

    String authID = UserPreferences().AuthID;

    print("Auth ID  :  " + authID);

    if(authID!=null && authID.isNotEmpty){

      List<String> imageUrls = await uploadFile(authID);

      addCustomCart(authID,imageUrls);

    }

  }

  Future<void> addCustomCart(String authID,List<String> imageUrls) async {

    try {

      var data = {
        "productType": bulkOrderCart.productID,
        "quantity": bulkOrderCart.quantity,
        "size": bulkOrderCart.size,
        "colour":['red'],
        "productID": bulkOrderCart.productID,
        "variantID": bulkOrderCart.variantID,
        "description": bulkOrderCart.description,
        "images": imageUrls,
      };

      final response =
      await http.post(FunctionConfig.host + 'manageCart/custom/{$authID}',
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"},
      );
      if (response.statusCode == 200) {

          print("Success");

      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }


}

  Future<List<String>> uploadFile(String authID) async {

    List<String> imageUrls = List();

    for(int i=0;i<logos.length;i++){

      String fileName = DateTime.now().toString();
      
      fb.StorageReference storageRef = fb.storage().ref('bulkOrderLogo/{$authID}').child(fileName);
      fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(logos.elementAt(i).imageFile).future;
      Uri imageUrl = await storageRef.getDownloadURL();
      imageUrls.add(imageUrl.toString());


    }

    return imageUrls;


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