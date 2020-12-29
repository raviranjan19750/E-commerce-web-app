import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/service/sharedPreferences.dart';



class MyBulkOrderProvider with ChangeNotifier{


  String authID;

  bool isInitialized = false;

  List<BulkOrder> bulkOrdItems = new List();

  void initBulkOrders() async {

    authID = UserPreferences().AuthID;

    await getBulkOrders(authID);

    isInitialized = true;

    notifyListeners();


  }

  Future<void> getBulkOrders(String authID) async {

    print("AuthID  :  " + authID);

    final response =
    await http.get(FunctionConfig.host + 'manageOrders/custom-list/$authID', headers: {"Content-Type": "application/json"},);

    if(response.statusCode == 200){

      bulkOrdItems.clear();

      bulkOrdItems = (jsonDecode(response.body) as List)
          .map((i) => BulkOrder.fromJson(i))
          .toList();


    }


  }

}