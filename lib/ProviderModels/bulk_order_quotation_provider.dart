import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/models/QuotationPayment.dart';
import 'package:living_desire/models/SamplePayment.dart';

class BulkOrderQuotationProvider with ChangeNotifier{


  BulkOrder bulkOrder;

  SamplePayment samplePayment;

  QuotationPayment quotationPayment;

  bool isInitialized = false;

  void initQuotation(String key) async {

    await getQuotation(key);

    String authID = FirebaseAuth.instance.currentUser.uid;


    await getSamplePaymentData(key, authID);

    await getQuotationPaymentData(key, authID);

    isInitialized = true;

    notifyListeners();

  }

  Future<void> getQuotation(String key) async{

    final response =
        await http.get(FunctionConfig.host + 'manageCustomOrder/custom-order/$key', headers: {"Content-Type": "application/json"},);

    if(response.statusCode == 200){

      bulkOrder = BulkOrder.fromJson(jsonDecode(response.body));

    }

  }

  Future<void> getSamplePaymentData(String key,String authID) async{

    final response =
    await http.post(FunctionConfig.host + 'managePayments/get-sample-order/$authID/$key', headers: {"Content-Type": "application/json"},);

    print("Sample Payment Data  : "  + response.body);

    if(response.statusCode == 200){


      samplePayment = SamplePayment.fromJson(jsonDecode(response.body));

    }

  }

  Future<void> getQuotationPaymentData(String key,String authID) async{

    final response =
    await http.post(FunctionConfig.host + 'managePayments/get-custom-order/$authID/$key', headers: {"Content-Type": "application/json"},);

    print("Quotation Payment Data  : "  + response.statusCode.toString());

    if(response.statusCode == 200){

      print("Quotation Payment Data  : "  + response.body);

      quotationPayment = QuotationPayment.fromJson(jsonDecode(response.body));

    }

  }


}