import 'package:flutter/material.dart';
import 'package:living_desire/config/palette.dart';


class NewOrderItem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(

          children: [

            Container(


              margin: EdgeInsets.only(left: 32),

              child: Image(

                height: 160,

                width: 120,

                image: AssetImage('assets/images/logo.jpeg'),

              ),

            ),

            Expanded(

              child: Container(

                margin: EdgeInsets.only(left: 32,top: 16),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(
                      children: [
                        Expanded(child: Container(child: Text('Classic Filled Bean Bag with Beans',style: TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.w100),),)),
                        Container(

                          margin: EdgeInsets.only(left: 48,right: 32),

                          child: InkWell(

                            onTap: (){},

                            child: Text('Need Help ?',style: TextStyle(decoration: TextDecoration.underline),),

                          ),
                        ),
                      ],
                    ),

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Row(
                          children: [

                            Column(

                              children: [
                                Text('₹ 2000',style: TextStyle(decoration: TextDecoration.lineThrough ,color: Colors.grey[500]),),

                                Text('₹ 1000',style: TextStyle(fontSize: 20,color: Palette.secondaryColor,fontWeight: FontWeight.w600),),

                              ],

                            ),

                            Container(margin:EdgeInsets.only(left: 16),child: Text('You saved ₹ 1000 (50%)',style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.w200),)),

                          ],

                        ),





                        Container(

                          margin: EdgeInsets.only(top: 8,bottom: 8),

                          child: Row(

                            children: [

                              Container(

                                margin: EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                                width: 16.0,
                                height: 16.0,
                                decoration: new BoxDecoration(
                                  color: Colors.redAccent,
                                  shape: BoxShape.circle,
                                ),
                              ),

                              Container(


                                margin: EdgeInsets.only(left: 16),

                                child: Text('Size : s',style: TextStyle(color: Palette.secondaryColor),),

                              ),

                              Container(

                                margin: EdgeInsets.only(left: 32),
                                child: Row(

                                  children: [

                                    Text(' Qty : ',style: TextStyle(color: Palette.secondaryColor),),

                                    Text(' 32 ',style: TextStyle(color: Palette.secondaryColor),),


                                  ],

                                ),

                              )

                            ],

                          ),
                        ),

                        Container(

                          margin: EdgeInsets.only(top: 16,bottom: 16),

                          child: InkWell(

                            onTap: (){},

                            child: Container(

                              padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                              decoration: BoxDecoration(

                                color: Palette.secondaryColor

                              ),

                              child: Text('Buy Again',style: TextStyle(color: Colors.white),),

                            ),

                          ),

                        ),

                      ],
                    ),


                  ],

                ),
              ),

            ),

          ],

        ),
        Container(height: 1,color: Colors.grey[500],)
      ],
    );

  }



}