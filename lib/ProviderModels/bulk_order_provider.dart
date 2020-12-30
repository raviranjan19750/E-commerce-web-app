
import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'dart:typed_data';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/models/uploadImage.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/service/sharedPreferences.dart';

class BulkOrderProvider with ChangeNotifier{

  double elevation = 4;
  double size = 1;

  bool sampleRequested = false;

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

  HashMap<String,List<String>> productTypeMap = new HashMap<String,List<String>>();
  
  List<String> subTypes = new List<String>();

  List<String> productTypeImages = new List();

  BulkOrderCart bulkOrderCart = new BulkOrderCart(productType: "",productSubType: "",variantID: "",size: "s",quantity: 50);


  ArsProgressDialog progressDialog;

  String buttonName = "ADD MORE";

  int editElementIndex = -1;

  Color pickerColor = Color(0xffffffff);
  Color currentColor = Color(0xffffffff);
  String hexColor ;

  void onSampleRequested(bool value){
    sampleRequested = value;
    notifyListeners();
  }

  void showColorPicker(BuildContext context){

    showDialog(
      context: context, builder: (context) => AlertDialog(
      title: const Text('Pick a color!'),

      content: SingleChildScrollView(
        child: ColorPicker(
          pickerColor: pickerColor,
          onColorChanged: (changeColor){

            pickerColor = changeColor;

          },
          showLabel: false,
          pickerAreaHeightPercent: 1,
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: const Text('Got it',style: TextStyle(fontSize: 20),),
          onPressed: () {
            currentColor = pickerColor;
            hexColor ='#${currentColor.value.toRadixString(16)}';
            notifyListeners();
            Navigator.of(context).pop();
          },
        ),
      ],
    ),
    );

  }

  void onItemSizeChanged(String s){

    itemSize = s;
    bulkOrderCart.size = s;
    notifyListeners();

  }

  void initStepOne(String productType, String productSubType) async {

    SearchApi searchApi = new SearchApi();

    List<FilterTag> list = await searchApi.getProductType();

    for(FilterTag f in list){

      for(FilterCategoryChild c in f.filterChilds){

        List<FilterTag> list = await searchApi.getSubTypes(c.filterID);

        if(list.length> 0){
          productTypeImages.add(list.first.filterChilds.first.description);
        }

        for(FilterTag f1 in list){

          List<String> subTypes = new List<String>();

          for(FilterCategoryChild c1 in f1.filterChilds){

            subTypes.add(c1.filterID);

          }

          productTypeMap.putIfAbsent(c.filterID, () => subTypes);

        }

      }
    }

    hexColor ='#${currentColor.value.toRadixString(16)}';

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
        await http.get(FunctionConfig.host + 'manageCart/custom/$authID', headers: {"Content-Type": "application/json"},);

    if(response.statusCode == 200){

      customCartItems.clear();

      customCartItems = (jsonDecode(response.body) as List)
          .map((i) => BulkOrderCart.fromJson(i))
          .toList();

    }

  }

  Future<void> deleteCustomCartItems(String key,int index) async {

    print("Key  :  " + key);

    String authID = UserPreferences().AuthID;

    final response =
        await http.delete(FunctionConfig.host + 'manageCart/custom/$authID/$key');

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

  void onEdit(BulkOrderCart bulkOrderCart,int index){

    this.bulkOrderCart.reset();
    this.bulkOrderCart.productType = bulkOrderCart.productType;
    this.bulkOrderCart.key = bulkOrderCart.key;
    this.bulkOrderCart.variantID = bulkOrderCart.variantID;
    this.bulkOrderCart.productSubType = bulkOrderCart.productSubType;
    this.bulkOrderCart.size = bulkOrderCart.size;
    this.bulkOrderCart.quantity = bulkOrderCart.quantity;
    this.bulkOrderCart.images = List.from(bulkOrderCart.images);

    logos.clear();

    for(String uri in this.bulkOrderCart.images){

      UploadImage uploadImage = new UploadImage(networkUri: uri);
      logos.add(uploadImage);

    }

    this.bulkOrderCart.colour = List.from(bulkOrderCart.colour);
    this.bulkOrderCart.description = bulkOrderCart.description;
    description = bulkOrderCart.description;

    currentColor = HexColorConvert.fromHex(bulkOrderCart.colour.first);
    hexColor ='#${currentColor.value.toRadixString(16)}';
    itemSize = bulkOrderCart.size;

    buttonName = "SAVE CHANGES";
    editElementIndex = index;

    stepTwoDone = false;
    stepOneDone = false;

    quantity = bulkOrderCart.quantity;
    quantityController.text = quantity.toString();

    selectedType = -1;

    for(int i=0;i<productTypeMap.keys.length;i++){

      if(productTypeMap.keys.elementAt(i) == bulkOrderCart.productType){
        selectedType = i;
      }

    }

    selectedSubType = -1;

    if(selectedType != -1){

      productTypeSelected = true;

      subTypes = productTypeMap[bulkOrderCart.productType];

      for(int i=0;i<productTypeMap[bulkOrderCart.productType].length;i++){

        if(productTypeMap[bulkOrderCart.productType].elementAt(i) == bulkOrderCart.productSubType){
          selectedSubType = i;
        }

      }

      if(selectedSubType !=-1){
        productSubTypeSelected = true;
      }
      else{
        productSubTypeSelected = false;
      }

    }
    else{

      subTypes = productTypeMap[productTypeMap.keys.first];
      productTypeSelected = false;
      productSubTypeSelected = false;

    }


    notifyListeners();

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
    bulkOrderCart.productType = productTypeMap.keys.elementAt(index);
    selectedSubType = -1;
    productSubTypeSelected = false;
    subTypes = productTypeMap.values.elementAt(index);
    notifyListeners();

  }

  void onProductSubTypeSelected(int index){

    productSubTypeSelected = true;
    selectedSubType = index;
    bulkOrderCart.productSubType = subTypes.elementAt(index);
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

  void updateQuantity(String s){

    quantity = int.tryParse(s);
    bulkOrderCart.quantity = quantity;

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

    if(authID!=null && authID.isNotEmpty){

      List<String> imageUrls = await uploadFile(authID);

      if(editElementIndex !=-1){
        updateCustomCart(authID, imageUrls,bulkOrderCart.key);
      }
      else{
        addCustomCart(authID,imageUrls);
      }


    }

  }

  Future<void> updateCustomCart(String authID,List<String> imageUrls,String key) async {

    try {

      List<String> colours = new List();

      colours.add(hexColor);

      bulkOrderCart.colour = colours;

      var data = {
        "productType": bulkOrderCart.productType,
        "productSubType": bulkOrderCart.productSubType,
        "quantity": bulkOrderCart.quantity,
        "size": bulkOrderCart.size,
        "colour":colours,
        "productID": bulkOrderCart.productID,
        "variantID": bulkOrderCart.variantID,
        "description": bulkOrderCart.description,
        "images": imageUrls,
      };

      final response =
      await http.put(FunctionConfig.host + 'manageCart/custom/$key',
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );

      print(response.body);


      if (response.statusCode == 200) {


        await getCustomCart(authID);

        dismissProgressDialog();

        onClear();


      }
      else{
        dismissProgressDialog();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }


  }

  Future<void> addCustomCart(String authID,List<String> imageUrls) async {

    try {

      List<String> colours = new List();

      colours.add(hexColor);

      bulkOrderCart.colour = colours;

      var data = {
        "productType": bulkOrderCart.productType,
        "productSubType": bulkOrderCart.productSubType,
        "quantity": bulkOrderCart.quantity,
        "size": bulkOrderCart.size,
        "colour":colours,
        "productID": bulkOrderCart.productID,
        "variantID": bulkOrderCart.variantID,
        "description": bulkOrderCart.description,
        "images": imageUrls,
      };

      final response =
      await http.post(FunctionConfig.host + 'manageCart/custom/$authID',
          body: jsonEncode(data),
          headers: {"Content-Type": "application/json"},
      );


      if (response.statusCode == 200) {

        var res = jsonDecode(response.body);

        String key = res['key'];

        bulkOrderCart.key = key;

        await getCustomCart(authID);

        dismissProgressDialog();

        onClear();


      }
      else{
        dismissProgressDialog();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }


}

  Future<List<String>> uploadFile(String authID) async {

    List<String> imageUrls = List();

    for(int i=0;i<logos.length;i++){

      if(logos.elementAt(i).imageFile!=null){

        String fileName = DateTime.now().toString();
        fb.StorageReference storageRef = fb.storage().ref('bulkOrderLogo/{$authID}').child(fileName);
        fb.UploadTaskSnapshot uploadTaskSnapshot = await storageRef.put(logos.elementAt(i).imageFile).future;
        Uri imageUrl = await storageRef.getDownloadURL();
        imageUrls.add(imageUrl.toString());

      }
      else{

        imageUrls.add(logos.elementAt(i).networkUri);

      }

    }

    return imageUrls;


  }

  Future<void> getQuotation() async {

    String authID = UserPreferences().AuthID;

    try{

      var data = {
        "isSampleRequested" : sampleRequested,
        "deliveryAddressID" : "2QFMUXPasBweaudXKg7a"
      };

      final response =
      await http.post(FunctionConfig.host + 'manageOrders/custom-request/$authID',
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
      );

      dismissProgressDialog();

      if(response.statusCode == 200){

        customCartItems.clear();
        onClear();

      }

      notifyListeners();

    }
    catch(e){
      throw Exception(e.toString());
    }


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
    editElementIndex = -1;
    buttonName = "ADD MORE";
    currentColor = Color(0xffffffff);
    logos.clear();
    bulkOrderCart.reset();
    notifyListeners();

  }

}