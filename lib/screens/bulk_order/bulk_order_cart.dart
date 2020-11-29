import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_cart_item.dart';

class BulkOrderCart extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(left:32),
      width: 400,

      decoration: BoxDecoration(

        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 2),
            blurRadius: 4.0,
          )],

        color: Colors.white

      ),


      child: Column(

        children: [

          Container(

              margin: EdgeInsets.only(top: 32,left: 16),
              alignment: Alignment.centerLeft,
              child: Text('Bulk Order in Cart',style: TextStyle(fontSize: 24,fontWeight: FontWeight.bold),)),

          Expanded(

            child: ListView.builder(

                shrinkWrap: true,
                itemCount: 5,
                itemBuilder:
                    (BuildContext context, int index) {
                  return Container(

                    padding: EdgeInsets.symmetric(horizontal: 16),

                    child: BulkOrderCartItem(),
                  );
                }),
          ),
          
          Container(
            
            margin: EdgeInsets.all(16),
            
            child: Row(

              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                Text('Get Sample ?',style: TextStyle(color: Colors.redAccent,fontSize: 24),),

                Switch(
                  value: false,
                  onChanged: (value){
                  },
                  activeTrackColor: Colors.black12,
                  activeColor: Palette.secondaryColor,
                ),

              ],

            ),
          ),

          Container(

            margin: EdgeInsets.all(16),

            width: double.infinity,

            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(8)
              
            ),

            child: RaisedButton(
              
              
              padding: EdgeInsets.only(left: 80,right: 80,top: 28,bottom: 28),

              onPressed: (){
              },

              color: Palette.secondaryColor,

              child: Text('Get Quotation',style: TextStyle(color: Colors.white,fontSize: 24),),

            ),
          ),

        ],

      ),

    );

  }



}