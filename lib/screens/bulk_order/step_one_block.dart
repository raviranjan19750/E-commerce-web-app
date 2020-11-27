import 'package:flutter/material.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_item.dart';

class StepOneBlock extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(

      children: [


        Container(

          width: double.infinity,

          padding: EdgeInsets.all(16),

          decoration: BoxDecoration(

            color: Palette.secondaryColor,

            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              )],

          ),

          margin: EdgeInsets.only(top: 32),

          child: Text('Select Item',style: TextStyle(color: Colors.white),),

        ),

        Container(

          width: double.infinity,
          height: 240,

          padding: EdgeInsets.all(16),

          decoration: BoxDecoration(

            color: Colors.white,

            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              )],

          ),


          child: ListView.builder(

              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 7,
              itemBuilder:
                  (BuildContext context, int index) {
                return Container(

                  padding: EdgeInsets.symmetric(horizontal: 16),

                  child: BulkOrderItem(),
                );
              })
          ,



        ),

      ],

    );

  }



}