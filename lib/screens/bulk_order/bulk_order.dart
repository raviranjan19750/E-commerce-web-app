import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/bulk_order/step_one_block.dart';
import 'package:living_desire/screens/bulk_order/step_three_block.dart';
import 'package:living_desire/screens/bulk_order/step_two_block.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';

import 'bulk_order_cart.dart';

class BulkOrder extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: CustomAppBar(size: 80,visibleSubAppBar: false,visibleMiddleAppBar: false,),

      body: Row(

        children: [

          Expanded(

            child: Container(

              padding: EdgeInsets.only(left: 32,right: 32),

              child: SingleChildScrollView(

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text('Order in Bulk',style: TextStyle(fontSize: 32 , fontWeight: FontWeight.bold),),

                    StepOneBlock(),

                    StepTwoBlock(),

                    StepThreeBlock(),

                    Row(

                      mainAxisAlignment: MainAxisAlignment.end,

                      children: [

                        Container(

                          margin: EdgeInsets.only(top: 16,bottom: 64),

                          decoration: BoxDecoration(

                            border: Border.all(color: Palette.secondaryColor),

                          ),

                          alignment: Alignment.centerLeft,

                          child: FlatButton(

                            padding: EdgeInsets.only(left: 80,right: 80,top: 28,bottom: 28),

                            onPressed: (){

                            },

                            color: Colors.white,

                            child: Text('Clear',style: TextStyle(color: Palette.secondaryColor,fontSize: 24),),

                          ),
                        ),

                        Container(

                          margin: EdgeInsets.only(top: 16,left: 32,bottom: 64),

                          alignment: Alignment.centerLeft,

                          child: RaisedButton(

                            padding: EdgeInsets.only(left: 80,right: 80,top: 28,bottom: 28),


                            onPressed: (){

                            },

                            color: Palette.secondaryColor,

                            child: Text('ADD MORE',style: TextStyle(color: Colors.white,fontSize: 24),),

                          ),
                        ),

                      ],

                    )

                  ],

                ),
              ),
            ),
          ),
          Container(height: double.infinity ,child: BulkOrderCart())
        ],
      ),

    );


  }



}