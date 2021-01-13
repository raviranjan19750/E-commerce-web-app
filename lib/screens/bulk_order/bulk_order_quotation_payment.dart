import 'package:flutter/material.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/models/QuotationPayment.dart';
import 'package:living_desire/widgets/order_screen/tracking_status_bar.dart';

class BulkOrderQuotationPayment extends StatelessWidget{

  QuotationPayment quotationPayment;

  BulkOrderQuotationPayment({this.quotationPayment});

  @override
  Widget build(BuildContext context) {


    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(

          margin: EdgeInsets.only(left: 32,top: 32,bottom: 8),

          child: Text('Quotation Payment',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),),

        ),

        Container(

          margin: EdgeInsets.only(left: 32,top: 8),

          child: Row(


            children: [

              Expanded(child: Text('Paying Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

              Text('₹ ${quotationPayment.payingAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

            ],

          ),

        ),
        Visibility(

          visible: (quotationPayment.paidAmount == 0),

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
        Container(

          margin: EdgeInsets.only(left: 32,top: 8),

          child: Row(


            children: [

              Expanded(child: Text('Paid Amount  : ',style: TextStyle(color: Colors.grey[500],fontSize: 20),)),

              Text('₹ ${quotationPayment.paidAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

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

              Text('₹ ${quotationPayment.totalPayingAmount}    ',style: TextStyle(color: Palette.secondaryColor,fontSize: 32,fontWeight: FontWeight.bold),),

            ],

          ),

        ),

        Visibility(

          visible: true,

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