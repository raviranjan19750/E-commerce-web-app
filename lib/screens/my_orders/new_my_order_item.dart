import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/my_orders/new_order_item.dart';


class NewMyOrderItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(left: 48,right: 48,top: 16,bottom: 16),

      decoration: BoxDecoration(

          border: Border.all(color: Colors.grey[500]),
          borderRadius: BorderRadius.circular(8)

      ),

      child: Column(

        children: [

          Container(

            decoration: BoxDecoration(color: Colors.grey[200]),

            child: Column(

              children: [

                Row(

                  children: [

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text('Placed On : ',style: TextStyle(color: Colors.grey[500])),),
                        Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text('20 JUN 2020',style: TextStyle(color: Palette.secondaryColor),),),

                      ],

                    ),

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text('Total :',style: TextStyle(color: Colors.grey[500])),),
                        Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text('Rs 2000',style: TextStyle(color: Palette.secondaryColor),),),

                      ],

                    ),

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text('Ship to :',style: TextStyle(color: Colors.grey[500])),),
                        Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text('Ravi Ranjan',style: TextStyle(color: Palette.secondaryColor),),),

                      ],

                    ),

                    Expanded(child: Container(),),

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text('Delivery Status :',style: TextStyle(color: Colors.grey[500])),),
                        Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text('On the Way',style: TextStyle(color: Palette.secondaryColor),),),

                      ],

                    ),

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4,right: 32) ,child: Text('Order ID : 110055064AD',style: TextStyle(color: Colors.grey[500])),),
                        Container(margin:EdgeInsets.only(left: 32,bottom: 8,right: 32) ,child: Text('Download Invoice',textAlign: TextAlign.end,style: TextStyle(color: Colors.blueAccent),),),

                      ],

                    ),


                  ],

                ),

              ],

            ),

          ),

          Container(height: 1,color: Colors.grey[500],),

          ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: 2,
              itemBuilder:
                  (BuildContext context, int index) {
                return Container(

                  padding: EdgeInsets.symmetric(horizontal: 16),

                  child:    NewOrderItem(),
                );
              }),


        ],
      ),

    );

  }



}