import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:http/http.dart' as http;

class MyProfileProvider with ChangeNotifier{


  void initProle() async {


    String authID = FirebaseAuth.instance.currentUser.uid;

    await getProfileDetails(authID);


  }

  Future<void> getProfileDetails(String authID) async {

    final response =
        await http.get(FunctionConfig.host + 'manageCustomerInfo/$authID', headers: {"Content-Type": "application/json"},);

    print("Account Info  : " + response.statusCode.toString());

    if(response.statusCode == 200){


        print("Account Info  : " + response.body);

    }

  }

  Future<void> saveProfileDetails(String authID) async {

    var data = {
      
      "name":"Ratul Chakraborty", 
      "email":"ratulc98@gmail.com", 
      "phone":"8617878497"
      
    };

    final response =
    await http.put(FunctionConfig.host + 'manageCustomerInfo/$authID',body: jsonEncode(data), headers: {"Content-Type": "application/json"},);

    print("Account put Info  : " + response.statusCode.toString());
    
    if(response.statusCode == 200){


      print("Account put Info  : " + response.body);

    }

  }

}