import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/order.dart';

class PlacedOrderProvider with ChangeNotifier{

  String authID;

  bool isInitialized = false;


  Order order;

  void initOrder(String key) async {


    await getOrder(key);

    isInitialized = true;

    notifyListeners();


  }

  Future<void> getOrder(String key) async {


    final response =
    await http.get(FunctionConfig.host + 'manageOrders/normal-order/$key', headers: {"Content-Type": "application/json"},);

    if(response.statusCode == 200){

      order = Order.fromJson(jsonDecode(response.body));


    }

    notifyListeners();

  }


}