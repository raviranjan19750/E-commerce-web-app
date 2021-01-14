import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/SamplePayment.dart';
import 'package:living_desire/screens/bulk_order/quotation_razor_pay.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:living_desire/widgets/order_screen/tracking_status_bar.dart';


class BulkOrderSamplePayment extends StatelessWidget{

  SamplePayment samplePayment;

  bool isPaid;

  String name,email,orderKey;

  ArsProgressDialog progressDialog;

  BulkOrderSamplePayment({this.samplePayment,this.isPaid,this.orderKey});

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

                    child: Text(message,style: TextStyle(fontSize: 20,color: Palette.secondaryColor),),

                  ),
                  CircularProgressIndicator(),
                ],
              )

          ),
        ));

  }

  Future<void> getProfileDetails(String authID,BuildContext context) async {

    final response =
    await http.get(FunctionConfig.host + 'manageCustomerInfo/$authID', headers: {"Content-Type": "application/json"},);

    dismissProgressDialog();

    if(response.statusCode == 200){


      Map<String,dynamic> map = jsonDecode(response.body);

      name = map['name'];
      email = map['email'];


    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuotationRazorPay(phone: FirebaseAuth.instance.currentUser.phoneNumber,
      payingAmount: samplePayment.totalPayingAmount,
      authID:FirebaseAuth.instance.currentUser.uid,
      orderID: samplePayment.orderID,
      razorPayOrderID: samplePayment.razorpayOrderID,
      deliveryCharges: samplePayment.deliveryCharges,
      samplePayment: true,
      orderKey: orderKey,
      name: (name!=null)?name:"",
      email: (email!=null)?email:"",)));

  }


  @override
  Widget build(BuildContext context) {

      return Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(

            margin: EdgeInsets.only(left: 16,top: 16,bottom: 8),

            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

            child: LabelTag('Sample Payment'),

          ),


          Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Paying Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${samplePayment.payingAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
          Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Tax  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${samplePayment.tax}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
          Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Delivery Charges  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${samplePayment.deliveryCharges}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),

          Container(
            margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
            height: 1,
            color: Palette.secondaryColor,
          ),

          Visibility(

            visible: samplePayment.totalPayingAmount>0,

            child: Container(

              margin: EdgeInsets.only(left: 32,top: 8),

              child: Row(


                children: [

                  Expanded(child: Text('Total Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                  Text('₹ ${samplePayment.totalPayingAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

                ],

              ),

            ),
          ),

          Visibility(

            visible: !isPaid,

            child: Container(

              margin: EdgeInsets.all(16),

              width: double.infinity,

              decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(8)

              ),

              child: RaisedButton(


                padding: EdgeInsets.only(left: 80,right: 80,top: 24,bottom: 24),

                onPressed: () async {



                    showProgressDialog(context, "Fetching Data");
                    await getProfileDetails(FirebaseAuth.instance.currentUser.uid,context);

                },

                color: Palette.secondaryColor,

                child: Text('Pay Now',style: TextStyle(color: Colors.white,fontSize: 24),),

              ),
            ),

            replacement: TrackingStatusBar(),
          ),

        ],

      );

  }



}