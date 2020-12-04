import 'package:flutter/material.dart';
import 'package:living_desire/screens/my_orders/my_order_item.dart';
import 'package:living_desire/screens/my_orders/new_my_order_item.dart';

class MyOrder extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(


            margin: EdgeInsets.only(left: 64,right: 64,top: 64),

            width: double.infinity,

            height: 1,

            color: Colors.grey[500],

          ),

          Container(

            color: Colors.redAccent,

            margin: EdgeInsets.only(left: 64,top: 4),

            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

            child: Text('10 Items',style: TextStyle(color: Colors.white,fontSize: 20),),

          ),

          Expanded(

            child: ListView.builder(

                itemCount: 7,
                itemBuilder:
                    (BuildContext context, int index) {
                  return Container(

                    padding: EdgeInsets.symmetric(horizontal: 16),

                    child: NewMyOrderItem(),
                  );
                }),
          ),

        ],

      ),
    );

  }



}