import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/SamplePayment.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:living_desire/widgets/order_screen/tracking_status_bar.dart';


class BulkOrderSamplePayment extends StatelessWidget{

  SamplePayment samplePayment;

  bool isPaid;

  BulkOrderSamplePayment({this.samplePayment,this.isPaid});

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

          Container(

            margin: EdgeInsets.only(left: 32,top: 8),

            child: Row(


              children: [

                Expanded(child: Text('Total Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

                Text('₹ ${samplePayment.totalPayingAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

              ],

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

                onPressed: (){


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