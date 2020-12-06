import 'dart:html';
import 'dart:ui' as ui;
//conditional import
import 'ui_fake.dart' if (dart.library.html) 'dart:ui' as ui;
import 'package:flutter/material.dart';
import '../../models/models.dart';
import 'dart:js' as js;

class RazorPayWeb extends StatelessWidget {
  final orderData;
  final List<Cart> carts;

  const RazorPayWeb({
    Key key,
    this.orderData,
    this.carts,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('razor pay');
    var razorpayPaymentID = '';
    var razorpayOrderID = '';
    var razorpaySignature = '';

    ui.platformViewRegistry.registerViewFactory("rzp-html", (int viewId) {
      IFrameElement element = IFrameElement();

      //Event Listener
      window.onMessage.forEach((element) {
        print('Event Received in callback: ${element.data}');
        if (element.data == 'MODAL_CLOSED') {
          Navigator.pop(context);
        } else if (element.data == 'SUCCESS') {
          print('PAYMENT SUCCESSFULL!!!!!!!');
        } else if (element.data.toString().contains('pay_id')) {
          razorpayPaymentID = element.data.toString().substring(6);

          print(razorpayPaymentID);
        } else if (element.data.toString().contains('order_id')) {
          razorpayOrderID = element.data.toString().substring(8);
          print(razorpayOrderID);
        } else if (element.data.toString().contains('sign')) {
          razorpaySignature = element.data.toString().substring(4);
          print(razorpaySignature);
        }
      });
      element.requestFullscreen();
      //element.src = 'assets/razorpay/payment.html';
      element.srcdoc = """<!DOCTYPE html><html>
<meta name="viewport" content="width=device-width">
<head><title>RazorPay Web Payment</title></head>
<body>
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>
<script>
      console.log("Razor pay options");
       var options = {
         "key": "rzp_test_U8mKfCB97ZZlEj",
          "amount": "50000", "currency": "INR",
          "name": "Living Desire",
          "description": "Test Transaction",
          "image": "https://example.com/your_logo",
          "order_id": "${orderData["razorpayOrderID"]}",
          "handler": function (response){
             window.parent.postMessage("SUCCESS","*"); 
                  //2 
             window.parent.postMessage("pay_id"+response.razorpay_payment_id);
             window.parent.postMessage("order_id"+response.razorpay_order_id);
             window.parent.postMessage("sign"+response.razorpay_signature);   
             
          },    
          "prefill": {        
             "name": "Gaurav Kumar",        
             "email": "gaurav.kumar@example.com",
             "contact": "9999999999"   
           },   
           "notes": {
             "orderID":"${orderData["notes"]["orderID"]}",
             "authID":"${orderData["notes"]["authID"]}",
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
    return Container(
      child: HtmlElementView(
        viewType: 'rzp-html',
      ),
    );
  }
}
