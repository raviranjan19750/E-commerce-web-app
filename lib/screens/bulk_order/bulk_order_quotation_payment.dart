import 'dart:convert';

import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/QuotationPayment.dart';
import 'package:living_desire/models/tracking.dart';
import 'package:living_desire/screens/bulk_order/quotation_razor_pay.dart';
import 'package:living_desire/screens/tracking/order_tracking.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:living_desire/widgets/order_screen/tracking_status_bar.dart';
import 'dart:html' as html;


class BulkOrderQuotationPayment extends StatelessWidget{

  QuotationPayment quotationPayment;

  bool isPaid;

  String name,email,orderKey,orderInvoiceUrl;

  List<Tracking> orderTracking;

  BulkOrderQuotationPayment({this.quotationPayment,this.isPaid,this.orderKey,this.orderInvoiceUrl,this.orderTracking});

  ArsProgressDialog progressDialog;

  void dismissProgressDialog(){
    progressDialog.dismiss();
  }

  void showPaymentDialog(BuildContext context){

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return Dialog(

          child: Container(

            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.6,

            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Select Payment Method
                  Text(
                    Strings.selectPaymentMethod,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ChoiceChip(
                        label: Container(
                          child: Row(
                            children: [
                              Ink.image(
                                image: AssetImage('assets/images/debit_card.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                children: [
                                  Text('Debit Card'),
                                  Text('Visa, MasterCard, ...etc.')
                                ],
                              ),
                            ],
                          ),
                        ),
                        selected: true,
                        elevation: 10,
                        pressElevation: 5,
                        selectedShadowColor: Colors.blue,
                        shadowColor: Colors.teal,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.blue,
                        onSelected: (bool selected) {

                        },
                      ),
                      ChoiceChip(
                        label: Container(
                          child: Row(
                            children: [
                              Ink.image(
                                image: AssetImage('assets/images/credit_card.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                children: [
                                  Text('Credit Card'),
                                  Text('Visa, MasterCard, ...etc.'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        selected: false,
                        elevation: 10,
                        pressElevation: 5,
                        shadowColor: Colors.teal,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.red,
                        onSelected: (bool selected) {

                        },
                      ),
                      ChoiceChip(
                        label: Container(
                          child: Row(
                            children: [
                              Ink.image(
                                image: AssetImage('assets/images/netbanking.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                children: [
                                  Text('Netbanking'),
                                  Text('HDFC, SBI, ICICI ...etc.'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        selected: false,
                        elevation: 10,
                        pressElevation: 5,
                        shadowColor: Colors.teal,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.blue,
                        onSelected: (bool selected) {

                        },
                      ),
                      ChoiceChip(
                        label: Container(
                          child: Row(
                            children: [
                              Ink.image(
                                image: AssetImage('assets/images/upi.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                children: [
                                  Text('UPI'),
                                  Text('Paytm, Gpay, Phonepe, ...etc.'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        selected: false,
                        elevation: 10,
                        pressElevation: 5,
                        shadowColor: Colors.teal,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.blue,
                        onSelected: (bool selected) {

                        },
                      ),
                      ChoiceChip(
                        label: Container(
                          child: Row(
                            children: [
                              Ink.image(
                                image: AssetImage('assets/images/wallet.png'),
                                height: 40,
                                width: 40,
                                fit: BoxFit.cover,
                              ),
                              Column(
                                children: [
                                  Text('Wallet'),
                                  Text('PAYTM, ...etc.'),
                                ],
                              ),
                            ],
                          ),
                        ),
                        selected: false,
                        elevation: 10,
                        pressElevation: 5,
                        shadowColor: Colors.teal,
                        backgroundColor: Colors.white,
                        selectedColor: Colors.blue,
                        onSelected: (bool selected) {

                        },
                      ),
                    ],
                  ),
                  // Submit Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {

                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            child: Text(Strings.submit),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );

      }
    );

  }


  void showProgressDialog(BuildContext context,String message){

    progressDialog = createProgressDialog(context,message);

    progressDialog.show();

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

    Navigator.of(context).push(MaterialPageRoute(builder: (context) => QuotationRazorPay(
      phone: FirebaseAuth.instance.currentUser.phoneNumber,
      totalPayingAmount: quotationPayment.totalPayingAmount,
      payingAmount: quotationPayment.payingAmount,
      authID:FirebaseAuth.instance.currentUser.uid,
      orderID: quotationPayment.orderID,
      razorPayOrderID: quotationPayment.razorpayOrderID,
      deliveryCharges: quotationPayment.deliveryCharges,
      samplePayment: false,
      orderKey: orderKey,
      name: (name!=null)?name:"",
      email: (email!=null)?email:"",)));

    //showPaymentDialog(context);

  }


  @override
  Widget build(BuildContext context) {


    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(

          margin: EdgeInsets.only(left: 16,top: 16,bottom: 8),

          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

          child: LabelTag('Quotation Payment'),

        ),

        Visibility(

          visible: (quotationPayment.paidAmount > 0),

          child: Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Paid Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text(' ₹ ${quotationPayment.paidAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
        ),

        Visibility(

          visible: (quotationPayment.payingAmount > 0),

          child: Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Paying Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${quotationPayment.payingAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
        ),

        Visibility(

          visible: (quotationPayment.tax > 0),

          child: Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Tax  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${quotationPayment.tax}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
        ),

        Visibility(

          visible: (quotationPayment.deliveryCharges > 0),

          child: Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Delivery Charges  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${quotationPayment.deliveryCharges}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
        ),

        Visibility(

          visible: (quotationPayment.totalPayingAmount == 0),

          child: Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Unpaid Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text(' ₹ ${quotationPayment.unpaidAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
        ),

        Visibility(

          visible: quotationPayment.totalPayingAmount>0,

          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 32,vertical: 16),
            height: 1,
            color: Palette.secondaryColor,
          ),
        ),

        Visibility(

          visible: quotationPayment.totalPayingAmount >0,

          child: Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Total Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${quotationPayment.totalPayingAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

            ),

          ),
        ),

        Visibility(

          visible: !(quotationPayment.totalPayingAmount == 0 && quotationPayment.unpaidAmount == 0),

          child: Container(

            margin: EdgeInsets.all(16),

            width: double.infinity,

            decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(8)

            ),

            child: Visibility(

              visible: quotationPayment.totalPayingAmount>0,

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
          ),

          replacement: Column(

            crossAxisAlignment: CrossAxisAlignment.center,

            children: [

              Container(

                alignment: Alignment.center,

                margin: EdgeInsets.symmetric(vertical: 16,horizontal: 16),

                child: RaisedButton(


                  padding: EdgeInsets.only(left: 80,right: 80,top: 24,bottom: 24),

                  onPressed: ()  {

                    /*html.window.open(orderInvoiceUrl, '');*/

                    showPaymentDialog(context);

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

                    List<Tracking> temp = new List.from(orderTracking.reversed);
                    showTrackingDialog(context, temp, "Order Tracking");

                  },


                  child: Container(


                    alignment: Alignment.center,

                    padding: EdgeInsets.only(top: 8,bottom: 8),

                    decoration: BoxDecoration(

                      border: Border.all(color: Palette.secondaryColor),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),

                    ),

                    child: Text('Track Order',style: TextStyle(color: Palette.secondaryColor,fontSize: 24),),

                  ),
                ),
              ),
            ],
          ),
        ),

      ],

    );

  }



}