import 'dart:convert';
import 'dart:html';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';

class MyProfileProvider with ChangeNotifier{


  String name;
  String email;
  String referralCode;



  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController nameTextEditingController = TextEditingController();

  bool isNameEdit = false;
  bool isEmailEdit = false;

  String authID,phone;

  bool isInitialized = false;

  ArsProgressDialog progressDialog;

  void initProle() async {


    authID = FirebaseAuth.instance.currentUser.uid;
    phone = FirebaseAuth.instance.currentUser.phoneNumber;

    await getProfileDetails(authID);

    await getReferralCode(authID);

    isInitialized = true;

    notifyListeners();


  }

  Future<void> getProfileDetails(String authID) async {

    final response =
        await CloudFunctionConfig.get('manageCustomerInfo/$authID');

    if(response.statusCode == 200){


        Map<String,dynamic> map = jsonDecode(response.body);

        name = map['name'];
        email = map['email'];

        emailTextEditingController.text = email;
        nameTextEditingController.text = name;

    }

  }

  Future<void> getReferralCode(String authID) async{

    final response =
    await CloudFunctionConfig.get('manageDiscountCoupons/my-referral/$authID');

    if(response.statusCode == 200){


      Map<String,dynamic> map = jsonDecode(response.body);

      referralCode = map['referralCode'];

    }

  }



  Future<void> saveProfileDetails(String authID,String name,String email) async {

    var data = {
      
      "name":name,
      "email":email,
      "phone":phone
      
    };

    final response =
    await CloudFunctionConfig.put('manageCustomerInfo/$authID', data);
    dismissProgressDialog();
    
    if(response.statusCode == 200){

      this.name = name;
      this.email = email;

      isEmailEdit = false;
      isNameEdit = false;

    }

  }

  void onNameEdit(){
    isNameEdit = !isNameEdit;
    isEmailEdit = false;
    nameTextEditingController.text = name;
    emailTextEditingController.text = email;
    notifyListeners();
  }

  void onEmailEdit(){
    isEmailEdit = !isEmailEdit;
    isNameEdit = false;
    nameTextEditingController.text = name;
    emailTextEditingController.text = email;
    notifyListeners();
  }

 void onEmailSave(BuildContext context) async {


    bool isValid = validateEmail(emailTextEditingController.text);

    if(isValid){

      showProgressDialog(context, 'Saving Email');

      await saveProfileDetails(authID, name, emailTextEditingController.text);

      notifyListeners();

    }
    else{

      Scaffold
          .of(context)
          .showSnackBar(

          SnackBar(
            duration: Duration(seconds: 2),
          backgroundColor: Colors.redAccent,content: Container(
          height: 56,
          child: Row(

            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Icon(Icons.error,size: 24,color: Colors.white,),
              Container(margin:EdgeInsets.only(left: 16),child: Text('Enter Valid Email',style: TextStyle(fontSize: 20),)),
            ],
          ))));

    }

 }

 void onNameSave(BuildContext context) async{

    if(nameTextEditingController.text.isNotEmpty && nameTextEditingController.text.length >= 3){

      showProgressDialog(context, 'Saving Username');

      await saveProfileDetails(authID, nameTextEditingController.text, email);

      notifyListeners();

    }
    else{

      Scaffold
          .of(context)
          .showSnackBar(

          SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Colors.redAccent,content: Container(
              height: 56,
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  Icon(Icons.error,size: 24,color: Colors.white,),
                  Container(margin:EdgeInsets.only(left: 16),child: Text('User name should be at least 3 characters',style: TextStyle(fontSize: 20),)),
                ],
              ))));

    }

 }

  bool validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return false;
    else
      return true;
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
                    Icons.save_outlined,
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

}