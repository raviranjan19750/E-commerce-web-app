import 'dart:convert';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/SamplePayment.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/screens/bulk_order/quotation_razor_pay.dart';
import 'package:living_desire/screens/tracking/order_tracking.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:living_desire/widgets/order_screen/tracking_status_bar.dart';
import 'dart:html' as html;

import '../../main.dart';
import '../../routes.dart';


class BulkOrderSamplePayment extends StatelessWidget{

  SamplePayment samplePayment;

  bool isPaid;

  String name,email,orderKey,sampleInvoiceURL;

  ArsProgressDialog progressDialog;

  List<Tracking> trackingList;

  BulkOrderSamplePayment({this.samplePayment,this.isPaid,this.orderKey,this.sampleInvoiceURL,this.trackingList});

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
    await CloudFunctionConfig.get('manageCustomerInfo/$authID');

    dismissProgressDialog();

    if(response.statusCode == 200){


      Map<String,dynamic> map = jsonDecode(response.body);

      name = map['name'];
      email = map['email'];


    }

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuotationRazorPay(phone: FirebaseAuth.instance.currentUser.phoneNumber,
      totalPayingAmount: samplePayment.totalPayingAmount,
      authID:FirebaseAuth.instance.currentUser.uid,
      orderID: samplePayment.orderID,
      razorPayOrderID: samplePayment.razorpayOrderID,
      deliveryCharges: samplePayment.deliveryCharges,
      samplePayment: true,
      orderKey: orderKey,
      name: (name!=null)?name:"",
      email: (email!=null)?email:"",)));

  }

  void showTrackingDialog(BuildContext context , List<Tracking> list,String title){

    showDialog(
        context: context,
        builder: (BuildContext context) {

          return AlertDialog(

            title: Text(title),

            content:Column(

              mainAxisSize: MainAxisSize.min,

              children: [

                OrderTracking(tracks: list,title: title,),

              ],

            ),

            actions: [

              FlatButton(onPressed: (){Navigator.pop(context);}, child: Container(padding:EdgeInsets.symmetric(horizontal: 16,vertical: 8),child: Text('Go Bak',style: TextStyle(color: Palette.secondaryColor),),))

            ],

          );

        }
    );

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

            replacement: Container( alignment: Alignment.center,child: Column(

              crossAxisAlignment: CrossAxisAlignment.center,

              children: [

                Container(

                  alignment: Alignment.center,

                  margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),

                  child: RaisedButton(


                    padding: EdgeInsets.only(left: 80,right: 80,top: 24,bottom: 24),

                    onPressed: ()  {

                      html.window.open(sampleInvoiceURL, '');

                    },

                    color: Palette.secondaryColor,

                    child: Text('Download Invoice',style: TextStyle(color: Colors.white,fontSize: 24),),

                  ),
                ),

                Container(

                  alignment: Alignment.center,

                  margin: EdgeInsets.symmetric(vertical: 16,horizontal: 72),

                  child: InkWell(

                   onTap: (){

                     List<Tracking> temp = new List.from(trackingList.reversed);
                     showTrackingDialog(context, temp, "Sample Tracking");

                   },


                    child: Container(


                      alignment: Alignment.center,

                      padding: EdgeInsets.only(top: 8,bottom: 8),

                      decoration: BoxDecoration(

                        border: Border.all(color: Palette.secondaryColor),
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),

                      ),

                      child: Text('Track Samples',style: TextStyle(color: Palette.secondaryColor,fontSize: 24),),

                    ),
                  ),
                ),
              ],
            ),),
          ),

        ],

      );

  }



}