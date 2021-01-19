import 'dart:convert';
import 'dart:html';
import 'dart:ui' as ui;
//conditional import
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/service/navigation_service.dart';

import '../../routes.dart';
import 'ui_fake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'dart:js' as js;

class RazorPayWeb extends StatelessWidget {
  final String razorpayOrderID;
  final int paymentMode;
  final String orderID;
  final double amount;
  final String authID;
  final String deliveryAddressID;
  final List<String> cartKeys;
  final String couponCode;
  final double couponAmount;
  final double deliveryCharges;

  const RazorPayWeb({
    Key key,
    this.razorpayOrderID,
    this.paymentMode,
    this.authID,
    this.cartKeys,
    this.amount,
    this.orderID,
    this.deliveryAddressID,
    this.couponAmount,
    this.couponCode,
    this.deliveryCharges,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('razor pay');
    print(razorpayOrderID);
    var razorpayPaymentID = '';
    var razorpayOrderIDWeb = '';
    var razorpaySignature = '';
    var blocConfig = {};
    String sequenceBloc = "";
    if (paymentMode == 101) {
      sequenceBloc = "block.debit_card";
    } else if (paymentMode == 102) {
      sequenceBloc = "block.credit_card";
    } else if (paymentMode == 103) {
      sequenceBloc = "block.netbanking";
    } else if (paymentMode == 104) {
      sequenceBloc = "block.upi";
    } else if (paymentMode == 105) {
      sequenceBloc = "block.wallet";
    }

    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();

      //Event Listener
      window.onMessage.forEach((element) async {
        print('Event Received in callback: ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (element.data.toString().contains('pay_id')) {
          razorpayPaymentID = element.data.toString().substring(6);
        } else if (element.data.toString().contains('order_id')) {
          razorpayOrderIDWeb = element.data.toString().substring(8);
        } else if (element.data.toString().contains('sign')) {
          razorpaySignature = element.data.toString().substring(4);
        } else if (element.data == 'SUCCESS') {
          print('PAYMENT SUCCESSFULL!!!!!!!');
          var data = {
            "orderID": "$orderID",
            "deliveryAddressID": "$deliveryAddressID",
            "deliveryCharges": deliveryCharges,
            "payingAmount": amount,
            "razorpayData": {
              "razorpayPaymentID": "$razorpayPaymentID",
              "razorpaySignature": "$razorpaySignature",
              "razorpayOrderID": "$razorpayOrderIDWeb",
              "paymentMode": paymentMode,
            },
            "cartKeys": cartKeys,
          };
          print(data);
          final response = await CloudFunctionConfig.post(
              'managePayments/normal-payment-done/$authID', data);
          if (response.statusCode == 200) {
            String key = (jsonDecode(response.body))["key"];
            locator<NavigationService>()
                .navigateTo(RoutesConfiguration.ORDER_PLACED, queryParams: {
              "key": key,
            });
          }
        }
      });
      element.requestFullscreen();
      //element.src = 'assets/razorpay/payment.html';
      element.srcdoc = """
<!DOCTYPE html><html>
<meta name="viewport" content="width=device-width">
<head><title>RazorPay Web Payment</title></head>
<body>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
      console.log("Razor pay options");
       var options = {
         "key": "rzp_test_U8mKfCB97ZZlEj",
          "amount": "${amount * 100}", "currency": "INR",
          "name": "Living Desire",
          "description": "",
          "image": "https://example.com/your_logo",
          config:{
            display:{
              blocks: {
                "debit_card":{
                  "name":"Pay Using Debit Card",
                  "instruments":[
                    {
                      "method": "card",
                      "types":[
                        "debit",
                      ],
                    },
                  ],
                },
                "credit_card":{
                  "name":"Pay Using Credit Card",
                  "instruments":[
                    {
                      "method": "card",
                      "types":[
                        "credit",
                      ],
                    },
                  ],
                },
                "netbanking":{
                  "name":"Pay Using Netbanking",
                  "instruments":[
                    {

                      "method": "netbanking",
                      
                    },
                  ],
                },
                "upi":{
                  "name":"Pay Using UPI apps",
                  "instruments":[
                    {
                      "method": "upi",
                      "flows": ["collect", "qr"],
                      "apps": ["google_pay", "bhim", "paytm", "amazon", "whatsapp", "phonepe"],
                      
                    },
                  ],
                },
                "wallet":{
                  "name":"Pay Using Popular Wallet",
                  "instruments":[
                    {
                      "method": "wallet",
                      
                      "wallets": [ "paypal" , "amazonpay",  "phonepe"],
                      
                    },
                  ],
                },
              },
              
              "sequence": [
                "$sequenceBloc",
              ],
              "preferences": {
                "show_default_blocks": false
              }
            },
          },
          "order_id": "$razorpayOrderID",
          "handler": function (response){
             
                  //2 
             window.parent.postMessage("pay_id"+response.razorpay_payment_id);
             window.parent.postMessage("order_id"+response.razorpay_order_id);
             window.parent.postMessage("sign"+response.razorpay_signature);
             window.parent.postMessage("SUCCESS","*");    
             
          },    
         
           "notes": {
             "orderID":"$orderID",
             "authID":"$authID",
           },    
          "theme": {
             "color": "#10CED7"    
          },
          "modal": {
            "ondismiss": function(){

               window.parent.postMessage("MODAL_CLOSED","*");   //3
            }
          }
       };

       var rzp1 = new Razorpay(options);
       window.onload = function(e){  //1  
          rzp1.open();
          e.preventDefault();
       }

     </script>
</body>
</html>
      """;

      element.style.border = 'none';

      return element;
    });
    return Container(
      child: HtmlElementView(
        viewType: 'rzp-html',
      ),
    );
  }
}
