import 'dart:collection';
import 'dart:convert';
import 'dart:html';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase/firebase.dart' as fb;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/DBHandler/local_storage.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:living_desire/models/uploadImage.dart';
import 'package:living_desire/service/searchapi.dart';

class BulkOrderProvider with ChangeNotifier {
  static const AUTO_ID_ALPHABET =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static const AUTO_ID_LENGTH = 20;

  double elevation = 4;
  double size = 1;

  bool sampleRequested = false;

  bool stepOneDone = false;

  bool stepTwoDone = false;

  bool onDataLoaded = false;

  TextEditingController quantityController =
      new TextEditingController(text: '1');

  bool productTypeSelected = false;

  bool productSubTypeSelected = false;

  int selectedType = -1;
  int selectedSubType = -1;

  String itemSize = "S";

  String description = "";

  List<UploadImage> logos = new List<UploadImage>();

  List<BulkOrderCart> customCartItems = new List();

  int quantity = 1;

  HashMap<String, List<String>> productTypeMap =
      new HashMap<String, List<String>>();

  List<String> subTypes = new List<String>();

  List<String> productTypeImages = new List();

  BulkOrderCart bulkOrderCart = new BulkOrderCart(
      productType: "",
      productSubType: "",
      variantID: "",
      size: "s",
      quantity: 1);

  ArsProgressDialog progressDialog;

  String buttonName = "ADD MORE";

  int editElementIndex = -1;

  Color selectedColor = Colors.white;
  String selectedColorName = Strings.white;
  String hexColor;

  void onSampleRequested(bool value) {
    sampleRequested = value;
    notifyListeners();
  }

  void onItemSizeChanged(String s) {
    itemSize = s;
    bulkOrderCart.size = s;
    notifyListeners();
  }

  void initStepOne(String productID, String variantID, String size,
      String productType, String productSubType,String color) async {
    SearchApi searchApi = new SearchApi();

    List<FilterTag> list = await searchApi.getProductType();

    for (FilterTag f in list) {
      for (FilterCategoryChild c in f.filterChilds) {
        List<FilterTag> list = await searchApi.getSubTypes(c.filterID);

        if (list.length > 0) {
          productTypeImages.add(list.first.filterChilds.first.description);
        }

        for (FilterTag f1 in list) {
          List<String> subTypes = new List<String>();

          for (FilterCategoryChild c1 in f1.filterChilds) {
            subTypes.add(c1.filterID);
          }

          productTypeMap.putIfAbsent(c.filterID, () => subTypes);
        }
      }
    }

    hexColor = '#${selectedColor.value.toRadixString(16)}';

    String authID;

    if (FirebaseAuth.instance.currentUser != null)
      authID = FirebaseAuth.instance.currentUser.uid;

    await getCustomCart(authID);

    if (productID == null || productID.isEmpty) {
      stepOneDone = false;
    } else {
      productTypeSelected = true;
      productSubTypeSelected = true;
      stepOneDone = true;

      bulkOrderCart.productID = productID;
      bulkOrderCart.variantID = variantID;
      bulkOrderCart.productType = productType;
      bulkOrderCart.productSubType = productSubType;
      bulkOrderCart.size = size;
      itemSize = size;
      hexColor = color;
      selectedColor = HexColorConvert.fromHex(color);

      selectedType = -1;

      for (int i = 0; i < productTypeMap.keys.length; i++) {
        if (productTypeMap.keys.elementAt(i) == bulkOrderCart.productType) {
          selectedType = i;
        }
      }

      selectedSubType = -1;

      if (selectedType != -1) {
        subTypes = productTypeMap[bulkOrderCart.productType];

        for (int i = 0;
            i < productTypeMap[bulkOrderCart.productType].length;
            i++) {
          if (productTypeMap[bulkOrderCart.productType].elementAt(i) ==
              bulkOrderCart.productSubType) {
            selectedSubType = i;
          }
        }
      } else {
        subTypes = productTypeMap[productTypeMap.keys.first];
      }
    }

    onDataLoaded = true;

    notifyListeners();
  }

  Future<void> getCustomCart(String authID) async {
    if (authID != null) {
      final response = await CloudFunctionConfig.get('manageCart/custom/$authID');

      print("Manage Cart  :  " + response.statusCode.toString());

      if (response.statusCode == 200) {
        customCartItems.clear();

        customCartItems = (jsonDecode(response.body) as List)
            .map((i) => BulkOrderCart.fromJson(i))
            .toList();
      }
    } else {
      final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');

      Map<dynamic, CustomCartLocal> customCart = _customcartlist.toMap();

      customCartItems.clear();

      customCart.forEach((key, value) {
        print("Custom Cart Map  :  " + key);

        BulkOrderCart bulkOrderCart = new BulkOrderCart(
            key: key,
            productID: value.productId,
            productType: value.productType,
            productSubType: value.productSubType,
            variantID: value.variantId,
            description: value.description,
            size: value.size,
            quantity: value.quantity,
            colour: value.colour,
            images: value.images);

        customCartItems.add(bulkOrderCart);
      });
    }
  }

  Future<void> deleteCustomCartItems(String key, int index) async {
    String authID;

    if (FirebaseAuth.instance.currentUser != null)
      authID = FirebaseAuth.instance.currentUser.uid;

    if (authID != null) {
      final response = await CloudFunctionConfig.delete('manageCart/custom/$authID/$key');
      dismissProgressDialog();

      if (response.statusCode == 200) {
        print("item deleted");
        customCartItems.removeAt(index);
        notifyListeners();
      }
    } else {
      CustomCartLocalStorage customCartLocalStorage =
          new CustomCartLocalStorage();

      customCartLocalStorage.deleteFromLocalStorage(key);

      customCartItems.removeAt(index);

      dismissProgressDialog();

      notifyListeners();
    }
  }

  void dismissProgressDialog() {
    progressDialog.dismiss();
  }

  void onEdit(BulkOrderCart bulkOrderCart, int index) {
    this.bulkOrderCart.reset();
    this.bulkOrderCart.productType = bulkOrderCart.productType;
    this.bulkOrderCart.key = bulkOrderCart.key;
    this.bulkOrderCart.variantID = bulkOrderCart.variantID;
    this.bulkOrderCart.productSubType = bulkOrderCart.productSubType;
    this.bulkOrderCart.size = bulkOrderCart.size;
    this.bulkOrderCart.quantity = bulkOrderCart.quantity;
    this.bulkOrderCart.images = List.from(bulkOrderCart.images);

    logos.clear();

    for (String uri in this.bulkOrderCart.images) {
      UploadImage uploadImage = new UploadImage(networkUri: uri);
      logos.add(uploadImage);
    }

    this.bulkOrderCart.colour = List.from(bulkOrderCart.colour);
    this.bulkOrderCart.description = bulkOrderCart.description;
    description = bulkOrderCart.description;

    hexColor = bulkOrderCart.colour.first['hexCode'];
    selectedColor = HexColorConvert.fromHex(hexColor);
    selectedColorName = bulkOrderCart.colour.first['name'];
    itemSize = bulkOrderCart.size;

    buttonName = "SAVE CHANGES";
    editElementIndex = index;

    stepTwoDone = false;
    stepOneDone = false;

    quantity = bulkOrderCart.quantity;
    quantityController.text = quantity.toString();

    selectedType = -1;

    for (int i = 0; i < productTypeMap.keys.length; i++) {
      if (productTypeMap.keys.elementAt(i) == bulkOrderCart.productType) {
        selectedType = i;
      }
    }

    selectedSubType = -1;

    if (selectedType != -1) {
      productTypeSelected = true;

      subTypes = productTypeMap[bulkOrderCart.productType];

      for (int i = 0;
          i < productTypeMap[bulkOrderCart.productType].length;
          i++) {
        if (productTypeMap[bulkOrderCart.productType].elementAt(i) ==
            bulkOrderCart.productSubType) {
          selectedSubType = i;
        }
      }

      if (selectedSubType != -1) {
        productSubTypeSelected = true;
      } else {
        productSubTypeSelected = false;
      }
    } else {
      subTypes = productTypeMap[productTypeMap.keys.first];
      productTypeSelected = false;
      productSubTypeSelected = false;
    }

    notifyListeners();
  }

  void onColorChange(Color color, String name) {
    hexColor = '#${color.value.toRadixString(16)}';
    selectedColor = HexColorConvert.fromHex(hexColor);
    selectedColorName = name;
    notifyListeners();
  }

  void showProgressDialog(BuildContext context, String message) {
    progressDialog = createProgressDialog(context, message);

    progressDialog.show();
  }

  ArsProgressDialog createProgressDialog(BuildContext context, String message) {
    return ArsProgressDialog(context,
        dismissable: false,
        blur: 2,
        backgroundColor: Color(0x33000000),
        loadingWidget: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8), color: Colors.white),
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
                margin: EdgeInsets.only(bottom: 16, top: 8),
                child: Text(
                  message,
                  style: TextStyle(fontSize: 20, color: Palette.secondaryColor),
                ),
              ),
              CircularProgressIndicator(),
            ],
          )),
        ));
  }

  void onProductTypeSelected(int index) {
    productTypeSelected = true;
    selectedType = index;
    bulkOrderCart.productType = productTypeMap.keys.elementAt(index);
    selectedSubType = -1;
    productSubTypeSelected = false;
    subTypes = productTypeMap.values.elementAt(index);
    notifyListeners();
  }

  void onProductSubTypeSelected(int index) {
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

        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          UploadImage uploadImage =
              new UploadImage(imageFile: file, uri: reader.result);

          logos.add(uploadImage);
          notifyListeners();
        });

        reader.onError.listen((fileEvent) {});

        reader.readAsArrayBuffer(file);
      }
    });
  }

  void deleteImage(int index) {
    logos.removeAt(index);

    notifyListeners();
  }

  void onStepOneDone() {
    stepOneDone = true;

    notifyListeners();
  }

  void onStepTwoDone() {
    stepTwoDone = true;
    notifyListeners();
  }

  void onStepTwoReverse() {
    stepTwoDone = false;
    notifyListeners();
  }

  void onStepOneReverse() {
    stepOneDone = false;
    notifyListeners();
  }

  void incrementQuantity(int val) {
    quantity++;
    bulkOrderCart.quantity = quantity;
    quantityController.text = quantity.toString();
    notifyListeners();
  }

  void updateQuantity(String s) {
    quantity = int.tryParse(s);
    bulkOrderCart.quantity = quantity;
  }

  void decrementQuantity(int val) {
    quantity--;
    bulkOrderCart.quantity = quantity;
    quantityController.text = quantity.toString();
    notifyListeners();
  }

  void addToCart() async {
    bulkOrderCart.description = description;

    String authID;

    if (FirebaseAuth.instance.currentUser != null)
      authID = FirebaseAuth.instance.currentUser.uid;

    if (authID != null && authID.isNotEmpty) {
      List<String> imageUrls = await uploadFile(authID);

      if (editElementIndex != -1) {
        updateCustomCart(authID, imageUrls, bulkOrderCart.key);
      } else {
        addCustomCart(authID, imageUrls);
      }
    } else {
      String key = _getAutoId();

      if (editElementIndex == -1) bulkOrderCart.key = key;

      bulkOrderCart.images = logos;

      var colours = [
        {
          'hexCode': hexColor,
          'name': selectedColorName,
        }
      ];

      bulkOrderCart.colour = colours;

      CustomCartLocalStorage customCartLocalStorage =
          new CustomCartLocalStorage(itm: bulkOrderCart);

      customCartLocalStorage.saveToLocalStorage();

      await getCustomCart(authID);

      dismissProgressDialog();

      onClear();
    }
  }

  Future<void> updateCustomCart(
      String authID, List<String> imageUrls, String key) async {
    try {
      var colours = [
        {
          'hexCode': hexColor,
          'name': selectedColorName,
        }
      ];

      bulkOrderCart.colour = colours;

      var data = {
        "productType": bulkOrderCart.productType,
        "productSubType": bulkOrderCart.productSubType,
        "quantity": bulkOrderCart.quantity,
        "size": bulkOrderCart.size,
        "colour": colours,
        "productID": bulkOrderCart.productID,
        "variantID": bulkOrderCart.variantID,
        "description": bulkOrderCart.description,
        "images": imageUrls,
      };

      final response = await CloudFunctionConfig.put('manageCart/custom/$key', data);

      print(response.body);

      if (response.statusCode == 200) {
        await getCustomCart(authID);

        dismissProgressDialog();

        onClear();
      } else {
        dismissProgressDialog();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<void> addCustomCart(String authID, List<String> imageUrls) async {
    try {
      var colours = [
        {
          'hexCode': hexColor,
          'name': selectedColorName,
        }
      ];

      bulkOrderCart.colour = colours;

      var data = {
        "productType": bulkOrderCart.productType,
        "productSubType": bulkOrderCart.productSubType,
        "quantity": bulkOrderCart.quantity,
        "size": bulkOrderCart.size,
        "colour": colours,
        "productID": bulkOrderCart.productID,
        "variantID": bulkOrderCart.variantID,
        "description": bulkOrderCart.description,
        "images": imageUrls,
      };

      final response = await CloudFunctionConfig.post('manageCart/custom/$authID', data);

      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);

        String key = res['key'];

        bulkOrderCart.key = key;

        await getCustomCart(authID);

        dismissProgressDialog();

        onClear();
      } else {
        dismissProgressDialog();
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  Future<List<String>> uploadFile(String authID) async {
    List<String> imageUrls = List();

    for (int i = 0; i < logos.length; i++) {
      if (logos.elementAt(i).imageFile != null) {
        String fileName = DateTime.now().toString();
        fb.StorageReference storageRef =
            fb.storage().ref('bulkOrderLogo/{$authID}').child(fileName);
        fb.UploadTaskSnapshot uploadTaskSnapshot =
            await storageRef.put(logos.elementAt(i).imageFile).future;
        Uri imageUrl = await storageRef.getDownloadURL();
        imageUrls.add(imageUrl.toString());
      } else {
        imageUrls.add(logos.elementAt(i).networkUri);
      }
    }

    return imageUrls;
  }

  Future<void> getQuotation() async {
    String authID;

    if (FirebaseAuth.instance.currentUser != null)
      authID = FirebaseAuth.instance.currentUser.uid;

    try {
      var data = {
        "isSampleRequested": sampleRequested,
        "deliveryAddressID": "2QFMUXPasBweaudXKg7a"
      };

      final response = await CloudFunctionConfig.post('manageOrders/custom-request/$authID', data);
      dismissProgressDialog();

      if (response.statusCode == 200) {
        customCartItems.clear();
        onClear();
      }

      notifyListeners();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void onClear() {
    selectedType = -1;
    selectedSubType = -1;
    quantity = 50;
    itemSize = "S";
    description = "";
    quantityController.text = quantity.toString();
    stepTwoDone = false;
    stepOneDone = false;
    productTypeSelected = false;
    productSubTypeSelected = false;
    editElementIndex = -1;
    buttonName = "ADD MORE";
    selectedColor = Color(0xffffffff);
    logos.clear();
    bulkOrderCart.reset();
    notifyListeners();
  }

  String _getAutoId() {
    final buffer = StringBuffer();
    final random = Random.secure();

    final maxRandom = AUTO_ID_ALPHABET.length;

    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      buffer.write(AUTO_ID_ALPHABET[random.nextInt(maxRandom)]);
    }
    return buffer.toString();
  }
}
