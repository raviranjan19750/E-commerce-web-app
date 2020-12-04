import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:living_desire/config/configs.dart';


class MyOrderItem extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.only(left: 64,right: 64,top: 16,bottom: 16),

      child: Column(

        children: [
          Row(

            children: [

              Container(

                decoration: BoxDecoration(

                    border: Border.all(color: Palette.secondaryColor),

                    color: Colors.grey[200]

                ),

                child: Image(

                  height: 200,

                  width: 150,

                  image: AssetImage('assets/images/logo.jpeg'),

                ),

              ),

              Expanded(

                child: Container(

                  margin: EdgeInsets.only(left: 32),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Container(child: Text('Classic Filled Bean Bag with Beans',style: TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.w100),),),

                      Row(

                        children: [

                          Container(child: Text('Order ID : ',style: TextStyle(fontSize: 16,color: Colors.grey[500],fontWeight: FontWeight.w100),),),
                          Container(child: Text('1100156515AD',style: TextStyle(fontSize: 20,color: Palette.secondaryColor),),),

                        ],

                      ),

                      Row(

                        children: [

                          Column(

                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [

                              Text('₹ 2000',style: TextStyle(decoration: TextDecoration.lineThrough ,color: Colors.grey[500]),),

                              Text('₹ 1000',style: TextStyle(fontSize: 20,color: Palette.secondaryColor,fontWeight: FontWeight.w600),),

                              Text('You saved ₹ 1000 (50%)',style: TextStyle(fontSize: 16,color: Colors.green,fontWeight: FontWeight.w200),),

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

                                margin: EdgeInsets.only(top: 16),

                                child: Row(


                                  children: [

                                    InkWell(

                                      onTap: (){},

                                      child: Container(

                                        padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                                        decoration: BoxDecoration(

                                          border: Border.all(color: Palette.secondaryColor),

                                        ),

                                        child: Text('View More'),

                                      ),

                                    ),

                                    Container(

                                      margin: EdgeInsets.only(left: 48),

                                      child: InkWell(

                                        onTap: (){},

                                        child: Text('Need Help ?',style: TextStyle(decoration: TextDecoration.underline),),

                                      ),
                                    ),



                                  ],

                                ),

                              ),

                            ],
                          ),

                          Container(

                            margin: EdgeInsets.symmetric(horizontal: 16),
                            width: 1,
                            height: 100,
                            color: Colors.grey[500],

                          ),

                          Container(

                            margin: EdgeInsets.only(left: 32),

                            child: Column(

                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [

                                Container(

                                  margin : EdgeInsets.only(top: 8,bottom: 8),
                                  child: Row(

                                    children: [

                                      Container(

                                        child: Text('Placed On :',style: TextStyle(color: Colors.grey[500]),),

                                      ),

                                      Container(

                                        margin: EdgeInsets.only(left: 24),

                                        child: Text('20 JUN 2020',style: TextStyle(color: Palette.secondaryColor),),

                                      ),

                                    ],

                                  ),
                                ),
                                Container(

                                  margin : EdgeInsets.only(top: 8,bottom: 8),
                                  child: Row(

                                    children: [

                                      Container(

                                        child: Text('Delivery Address :',style: TextStyle(color: Colors.grey[500]),),

                                      ),

                                      Container(


                                        margin: EdgeInsets.only(left: 24),

                                        child: Text(' Ravi Ranjan \n 682/1, house no 7 , street no 5, Deoli village , \n Satya sai public school New Delhi - 110062, Delhi',style: TextStyle(color: Palette.secondaryColor),),

                                      ),

                                    ],

                                  ),
                                ),
                                Container(

                                  margin : EdgeInsets.only(top: 8,bottom: 8),
                                  child: Row(

                                    children: [

                                      Container(

                                        child: Text('Phone Number:',style: TextStyle(color: Colors.grey[500]),),

                                      ),

                                      Container(

                                        margin: EdgeInsets.only(left: 24),

                                        child: Text('9821951461',style: TextStyle(color: Palette.secondaryColor),),

                                      ),

                                    ],

                                  ),
                                ),


                              ],
                            ),
                          )

                        ],
                      )


                    ],

                  ),
                ),

              ),

              Container(

                margin: EdgeInsets.only(left: 64),

                child: Column(

                  children: [

                    Container(

                      color: Colors.redAccent,

                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                      margin: EdgeInsets.only(bottom: 64),

                      child: Visibility(visible : true,child: Text('Combo',style: TextStyle(color: Colors.white,fontSize: 14),)),

                    ),

                    InkWell(
                      onTap: (){},

                      child: RatingBar.builder(
                        initialRating: 1,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 24,
                        itemPadding: EdgeInsets.symmetric(horizontal: 0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),

                    Container(margin:EdgeInsets.only(top: 8),child: Text('Rate & Review',style: TextStyle(decoration:TextDecoration.underline,color: Colors.orange,fontSize: 16,fontWeight: FontWeight.w700),))

                  ],

                ),

              )

            ],

          ),
          Container(

            margin: EdgeInsets.only(top: 32),

            width: double.infinity,
            height: 1,
            color: Colors.grey[500],

          )
        ],
      ),

    );

  }



}