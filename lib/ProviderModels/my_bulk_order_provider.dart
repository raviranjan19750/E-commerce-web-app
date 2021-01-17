import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/BulkOrder.dart';



class MyBulkOrderProvider with ChangeNotifier{


  String authID;

  bool isInitialized = false;

  List<BulkOrder> bulkOrdItems = new List();

  void initBulkOrders() async {



    authID = FirebaseAuth.instance.currentUser.uid;

    await getBulkOrders(authID);

    isInitialized = true;

    notifyListeners();


  }

  Future<void> getBulkOrders(String authID) async {


    final response =
    await CloudFunctionConfig.get('manageCustomOrder/custom-list/$authID');

    if(response.statusCode == 200){

      bulkOrdItems.clear();

      bulkOrdItems = (jsonDecode(response.body) as List)
          .map((i) => BulkOrder.fromJson(i))
          .toList();

      bulkOrdItems.sort((a,b) => b.requestDate.compareTo(a.requestDate));


    }


  }

}