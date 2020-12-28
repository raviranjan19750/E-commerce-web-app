import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/StringToHexColor.dart';

class BulkOrderCartItem extends StatelessWidget{

  List<BulkOrderCart> items;
  int index;
  BulkOrderProvider value;

  BulkOrderCartItem({this.items,this.index,this.value});

  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        Row(

          children: [

            Image(

              color: Palette.secondaryColor,

              image: AssetImage(''),

              height: 120,

              width: 64,

            ),

            Expanded(

              child: Column(


                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(margin : EdgeInsets.only(left: 16,bottom: 8),child: Text(items.elementAt(index).productType,style: TextStyle(fontSize: 20),)),

                  Row(
                    children: [

                      Container(

                        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        width: 24.0,
                        height: 24.0,
                        decoration: new BoxDecoration(
                          color: HexColorConvert.fromHex(items.elementAt(index).colour.first),
                          shape: BoxShape.circle,
                        ),
                      ),

                      Container(


                        margin: EdgeInsets.only(left: 8),

                        decoration: BoxDecoration(

                          border: Border.all(color: Palette.secondaryColor),

                          borderRadius: BorderRadius.circular(4),

                          color: Colors.white,

                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 4.0,
                            )],

                        ),
                        padding: EdgeInsets.all(4),

                        child: Text('Size : s',style: TextStyle(color: Palette.secondaryColor),),

                      ),

                      Container(

                        margin: EdgeInsets.only(left: 8),
                        decoration: BoxDecoration(

                          border: Border.all(color: Palette.secondaryColor),

                          borderRadius: BorderRadius.circular(4),

                          color: Colors.white,

                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 2),
                              blurRadius: 4.0,
                            )],

                        ),
                        padding: EdgeInsets.all(4),

                        child: Row(

                          children: [

                            Text(' Qty : ',style: TextStyle(color: Palette.secondaryColor),),

                            Text(items.elementAt(index).quantity.toString(),style: TextStyle(color: Palette.secondaryColor),),


                          ],

                        ),

                      )

                    ],

                  )

                ],

              ),

            ),

            Column(

              children: [

                IconButton(

                  onPressed: (){

                    value.showProgressDialog(context, "Removing item from cart");
                    value.deleteCustomCartItems(items.elementAt(index).key, index);

                  },

                  icon: Icon(Icons.highlight_remove_sharp),
                  color: Colors.grey[500],

                ),

                IconButton(

                  onPressed: (){},

                  icon: Icon(Icons.edit),
                  color: Colors.grey[500],

                )

              ],
            )

          ],

        ),

        Container(

          color: Colors.grey[500],

          height: 0.5,

        ),

      ],

    );

  }



}