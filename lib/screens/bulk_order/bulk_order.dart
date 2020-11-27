import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/bulk_order/step_one_block.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';

class BulkOrder extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: CustomAppBar(),

      body: SingleChildScrollView(

        child: Container(

          padding: EdgeInsets.only(left: 32,right: 32),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text('Order in Bulk',style: TextStyle(fontSize: 32 , fontWeight: FontWeight.bold),),

              StepOneBlock(),


            ],

          ),

        ),
      ),

    );


  }



}