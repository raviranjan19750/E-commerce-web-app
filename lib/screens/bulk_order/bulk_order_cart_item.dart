import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class BulkOrderCartItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(

      children: [

        Row(

          children: [

            Image(

              color: Palette.secondaryColor,

              image: AssetImage('assets/images/logo.jpeg'),

              height: 120,

              width: 64,

            ),

            Expanded(

              child: Column(


                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Container(margin : EdgeInsets.only(left: 16,bottom: 8),child: Text('Bean Bag with beans',style: TextStyle(fontSize: 20),)),

                  Row(
                    children: [

                      Container(

                        margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                        width: 24.0,
                        height: 24.0,
                        decoration: new BoxDecoration(
                          color: Colors.redAccent,
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

                            Text(' 32 ',style: TextStyle(color: Palette.secondaryColor),),


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

                  onPressed: (){},

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