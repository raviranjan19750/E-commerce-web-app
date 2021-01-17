import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';

import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/models/QuotationPayment.dart';
import 'package:living_desire/models/SamplePayment.dart';

class BulkOrderQuotationProvider with ChangeNotifier{


  BulkOrder bulkOrder;

  SamplePayment samplePayment;

  QuotationPayment quotationPayment;

  bool isInitialized = false;

  bool samplePaymentUploaded = false;

  bool samplePaymentPaid = false;

  bool quotationPaymentPaid = false;

  bool quotationPaymentUploaded = false;

  void initQuotation(String key) async {

    await getQuotation(key);

    String authID = FirebaseAuth.instance.currentUser.uid;

    if(bulkOrder.isSampleRequested)
      await getSamplePaymentData(key, authID);
    else{
      samplePaymentUploaded = false;
      samplePaymentPaid = false;
    }

    await getQuotationPaymentData(key, authID);

    isInitialized = true;

    notifyListeners();

  }

  Future<void> getQuotation(String key) async{

    final response =
        await  CloudFunctionConfig.get('manageCustomOrder/custom-order/$key');
    if(response.statusCode == 200){



      bulkOrder = BulkOrder.fromJson(jsonDecode(response.body));
    }

  }

  Future<void> getSamplePaymentData(String key,String authID) async{

    final response =
    await CloudFunctionConfig.post('managePayments/get-sample-order/$authID/$key', {});
    if(response.statusCode == 200){

      samplePayment = SamplePayment.fromJson(jsonDecode(response.body));

      samplePaymentUploaded = true;
      samplePaymentPaid = false;

    }
    else if(response.statusCode == 501){

      samplePaymentUploaded = false;
      samplePaymentPaid = false;
    }
    else if(response.statusCode == 502){

      samplePayment = SamplePayment.fromJson(jsonDecode(response.body));

      samplePaymentUploaded = true;
      samplePaymentPaid = true;
    }

  }

  Future<void> getQuotationPaymentData(String key,String authID) async{

    final response =
    await  CloudFunctionConfig.post('managePayments/get-custom-order/$authID/$key', {});

    print("Quotation Payment Data  : "  + response.statusCode.toString());

    if(response.statusCode == 200){

      quotationPayment = QuotationPayment.fromJson(jsonDecode(response.body));

      quotationPaymentUploaded = true;
      quotationPaymentPaid = false;

    }
    else if(response.statusCode == 501){

      quotationPaymentUploaded = false;
      quotationPaymentPaid = false;
    }
    else if(response.statusCode == 502){
      quotationPaymentUploaded = true;
      quotationPaymentPaid = true;
    }


  }


}