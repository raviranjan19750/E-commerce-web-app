import 'dart:convert';
import 'dart:html';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/services/razorpay/ui_fake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';

import '../../routes.dart';

class QuotationRazorPay extends StatelessWidget {

  String phone,name,email,authID,orderID;
  double payingAmount,deliveryCharges;
  bool samplePayment;
  String orderKey;

  QuotationRazorPay({
    this.phone,
    this.payingAmount,
    this.name,
    this.email,
    this.orderKey,
    this.authID,
    this.orderID,
    this.deliveryCharges,
    this.samplePayment,
  });


  ArsProgressDialog progressDialog;

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
                    Icons.account_balance_wallet_outlined,
                    color: Colors.grey[500],
                    size: 48,
                  ),

                  Container(

                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 16,top: 8),

                    child: Text(message,style: TextStyle(fontSize: 20,color: Palette.secondaryColor),textAlign: TextAlign.center,),

                  ),
                  CircularProgressIndicator(),
                ],
              )

          ),
        ));

  }

  Future<void> updateSamplePaymentData(String razorpayID,String razorpayOrderID,String razorpaySignature) async {

    var data = {

        "sampleOrderID" : razorpayOrderID,
        "deliveryCharges" : deliveryCharges,
        "razorpayData " : {

            "razorpayPaymentID":razorpayID,
            "razorpaySignature":razorpaySignature,
            "amount": payingAmount,
            "paymentMode" : "Net Banking",

        },


    };

    final response =
        await http.post(FunctionConfig.host + 'managePayments/sample-payment-done/$authID/$orderKey',body: jsonEncode(data), headers: {"Content-Type": "application/json"},);

    dismissProgressDialog();

    if(response.statusCode == 200){


      Map<String,dynamic> map = jsonDecode(response.body);

      locator<NavigationService>().navigateTo(RoutesConfiguration.BULK_ORDER_QUOTATION, queryParams: {"key": orderKey});

    }



  }

  Future<void> updateQuotationPaymentData(String razorpayID,String razorpayOrderID,String razorpaySignature) async {

    var data = {

      "sampleOrderID" : razorpayOrderID,
      "razorpayData " : {

        "razorpayPaymentID":razorpayID,
        "razorpaySignature":razorpaySignature,
        "amount": payingAmount,
        "paymentMode" : "Net Banking",

      },


    };


    final response =
    await http.post(FunctionConfig.host + 'managePayments/custom-payment-done/$authID/$key', body: jsonEncode(data), headers: {"Content-Type": "application/json"},);


    if(response.statusCode == 200){


      Map<String,dynamic> map = jsonDecode(response.body);

    }

    dismissProgressDialog();


  }

  @override
  Widget build(BuildContext context) {

    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {

      IFrameElement element = IFrameElement();

      //Event Listener

      window.onMessage.forEach((element) {

        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        }
        else if (element.data.toString().contains('SUCCESS')) {

          String data = element.data.toString().substring(8);

          List<String> response = data.split(' ');

          String razorpayPaymentID = response[0];
          String razorpayOrderID = response[1];
          String razorpaySignature = response[2];

          if(samplePayment){
            showProgressDialog(context, "Transaction Successful\n\nRedirecting...");
            updateSamplePaymentData(razorpayPaymentID, razorpayOrderID, razorpaySignature);
          }
          else{

          }


        }

      });


      element.requestFullscreen();

      element.srcdoc = """<!DOCTYPE html><html>
<meta name="viewport" content="width=device-width">
<head><title>RazorPay Web Payment</title></head>
<body>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
      console.log("Razor pay options");
       var options = {
         "key": "rzp_test_U8mKfCB97ZZlEj",
          "amount": ${payingAmount*100}, "currency": "INR",
          "name": "Living Desire",
          "description": "Test Transaction",
          "image": "https://example.com/your_logo",
          "order_id": "$orderID",
          "handler": function (response){
       
             window.parent.postMessage("SUCCESS" + " " + response.razorpay_payment_id + " " + response.razorpay_order_id + " " + response.razorpay_signature);  
          },    
             
           "prefill": {
              "name": "$name",
              "email": "$email",
              "contact": "$phone"
          },
             
           "notes": {
           
             "orderID":"$orderID",
             "authID":"$authID",
         
           },    
           
           
          "theme": {
             "color": "#DF0145"    
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
</html>""";
      // print('HTML src');
      // element.setInnerHtml(
      //   html,
      //   validator: NodeValidatorBuilder.common()..allowElement('script'),
      // );
      element.style.border = 'none';

      return element;

    });


    return Scaffold(
      body: Container(
        child: HtmlElementView(
          viewType: 'rzp-html',
        ),
      ),
    );
  }
}
