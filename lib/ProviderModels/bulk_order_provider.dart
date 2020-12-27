
import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
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

  bool onDataLoaded = false;

  TextEditingController quantityController = new TextEditingController(text: '50');

  bool productTypeSelected = false;

  bool productSubTypeSelected = false;

  int selectedType = -1;
  int selectedSubType = -1;

  String itemSize = "S";

  String description  = "";

  List<UploadImage> logos = new List<UploadImage>();

  List<BulkOrderCart> customCartItems = new List();

  int quantity = 50;

  BulkOrderCart bulkOrderCart = new BulkOrderCart();

  HashMap<String,List<String>> productTypeMap = new HashMap<String,List<String>>();
  
  List<String> subTypes = new List<String>();

  ArsProgressDialog progressDialog;

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

    await getCustomCart(UserPreferences().AuthID);

    if(productType == null || productType.isEmpty){

      stepOneDone = false;
    }
    else{

      stepOneDone = true;

      bulkOrderCart.productID = productType;
      bulkOrderCart.variantID = productSubType;

    }

    onDataLoaded = true;

    notifyListeners();

  }

  Future<void> getCustomCart(String authID) async {

    final response =
        await http.get(FunctionConfig.host + 'manageCart/custom/{$authID}', headers: {"Content-Type": "application/json"},);

    if(response.statusCode == 200){

      customCartItems.clear();

      customCartItems = (jsonDecode(response.body) as List)
          .map((i) => BulkOrderCart.fromJson(i))
          .toList();

    }

  }

  Future<void> deleteCustomCartItems(String key,int index) async {

    print("Key  :  " + key + "  index  :  " + index.toString());

    final response =
        await http.delete(FunctionConfig.host + 'manageCart/custom/{$key}', headers: {"Content-Type": "application/json"},);

    print("Status Code  :  "+ response.statusCode.toString());

    dismissProgressDialog();

    if(response.statusCode == 200){

      print("item deleted");
      customCartItems.removeAt(index);
      notifyListeners();

    }


  }

  void dismissProgressDialog(){
    progressDialog.dismiss();
  }

  void showProgressDialog(BuildContext context,String message){

    progressDialog = createProgressDialog(context,message);

    progressDialog.show();

  }

  ArsProgressDialog createProgressDialog(BuildContext context,String message){

    return ArsProgressDialog(context,
        dismissable: false,
        blur: 2,
        backgroundColor: Color(0x33000000),
        loadingWidget: Container(
          decoration: BoxDecoration(

            borderRadius: BorderRadius.circular(8),
            color: Colors.white

          ),
          width: 360,
          height: 240,
          child: Center(

              child: Column(

                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(
                    Icons.shopping_cart,
                    color: Colors.grey[500],
                    size: 48,
                  ),

                  Container(

                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 16,top: 8),

                    child: Text(message,style: TextStyle(fontSize: 20,color: Palette.secondaryColor),),

                  ),
                  CircularProgressIndicator(),
                ],
              )

          ),
        ));

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

      dismissProgressDialog();

      if (response.statusCode == 200) {

        customCartItems.add(bulkOrderCart);
        onClear();
        notifyListeners();


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