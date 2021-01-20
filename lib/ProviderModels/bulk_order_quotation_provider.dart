import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';

import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/models/PaymentMethod.dart';
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

  int selectedPaymentIndex = -1;

  int selectedPaymentMethod = 0;

  List<PaymentMethod> paymentMethods = [

    new PaymentMethod(code: 101,asset: 'assets/images/debit_card.png',description: 'Visa, MasterCard, ...etc.',value: 'Debit Card'),
    new PaymentMethod(code: 102,asset: 'assets/images/credit_card.png',description: 'Visa, MasterCard, ...etc.',value: 'Credit Card'),
    new PaymentMethod(code: 103,asset: 'assets/images/netbanking.png',description: 'Visa, MasterCard, ...etc.',value: 'NetBanking'),
    new PaymentMethod(code: 104,asset: 'assets/images/google_pay.png',description: 'Google Pay',value: 'UPI'),
    new PaymentMethod(code: 105,asset: 'assets/images/upi.png',description: 'BHIM',value: 'UPI'),
    new PaymentMethod(code: 106,asset: 'assets/images/paytm.png',description: 'PayTM',value: 'UPI'),
    new PaymentMethod(code: 107,asset: 'assets/images/amazon.png',description: 'Amazon',value: 'UPI'),
    new PaymentMethod(code: 108,asset: 'assets/images/whatsapp.png',description: 'WhatsApp',value: 'UPI'),
    new PaymentMethod(code: 109,asset: 'assets/images/pone_pe.png',description: 'PhonePe',value: 'UPI'),
    new PaymentMethod(code: 110,asset: 'assets/images/pone_pe.png',description: 'PhonePe',value: 'Wallet'),
    new PaymentMethod(code: 111,asset: 'assets/images/paytm.png',description: 'PayTM',value: 'Wallet'),
    new PaymentMethod(code: 112,asset: 'assets/images/amazon_pay.png',description: 'AmazonPay',value: 'Wallet'),
    new PaymentMethod(code: 113,asset: 'assets/images/cash_on_delivery.png',description: 'Cash on Delivery',value: 'Cash'),

  ];

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

  void onPaymentMethodSelected(int index){

    selectedPaymentIndex = index;
    selectedPaymentMethod = paymentMethods.elementAt(index).code;

    notifyListeners();

  }


}