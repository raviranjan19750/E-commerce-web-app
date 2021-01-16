import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
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
    await CloudFunctionConfig.get('manageOrders/normal-order/$key');
    if(response.statusCode == 200){

      order = Order.fromJson(jsonDecode(response.body));


    }

    notifyListeners();

  }


}