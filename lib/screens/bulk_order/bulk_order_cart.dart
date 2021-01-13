import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_cart_item.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';

class BulkOrderCart extends StatelessWidget{

  BulkOrderProvider value;

  BulkOrderCart({this.value});

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(left:32),
      width: 400,
      height: double.infinity,

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

            margin: EdgeInsets.only(top: 8,bottom: 8),

            alignment: Alignment.centerLeft,

            padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

            child: LabelTag('Bulk Order in Cart'),

          ),

          Expanded(

            child: Visibility(

              visible: value.onDataLoaded,

              replacement: Center(

                child: CircularProgressIndicator(),

              ),

              child: Visibility(

                visible: (value.customCartItems.length !=0),

                replacement: Column(

                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [

                    Icon(
                      Icons.shopping_cart,
                      color: Colors.grey[500],
                      size: 72,
                    ),

                    Container(

                      padding: EdgeInsets.all(8),
                      margin: EdgeInsets.only(bottom: 16,top: 32),

                      child: Text("Your Cart is empty",style: TextStyle(fontSize: 20,color: Palette.secondaryColor),),

                    ),
                  ],
                ),

                child: ListView.builder(


                    shrinkWrap: true,
                    itemCount: value.customCartItems.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Container(

                        padding: EdgeInsets.symmetric(horizontal: 16),

                        child: BulkOrderCartItem(items: value.customCartItems,index: index,value: value,),
                      );
                    }),
              ),
            ),
          ),
          
          Container(
            
            margin: EdgeInsets.all(16),
            
            child: Row(

              mainAxisAlignment: MainAxisAlignment.end,

              children: [

                Text('Get Sample ?',style: TextStyle(color: Colors.redAccent,fontSize: 24),),

                Switch(

                  value: value.sampleRequested,

                  onChanged: (v){
                    value.onSampleRequested(v);
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

                /*Navigator.pushNamed(
                    context, RoutesConfiguration.SELECT_ADDRESS,
                    arguments: {
                      "totalItems": value.customCartItems.length,
                      "sampleRequested": value.sampleRequested,
                      "isBulkOrder": true,
                    });*/

                value.showProgressDialog(context, "Generating Quotation");
                value.getQuotation();

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