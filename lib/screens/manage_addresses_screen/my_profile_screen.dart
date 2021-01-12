import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class MyProfileScreen extends StatelessWidget{


  @override
  Widget build(BuildContext context) {

    return Container(

      margin: EdgeInsets.all(32),

      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [
              Container(margin:EdgeInsets.only(bottom: 16),child: Text('Personal Information',style: TextStyle(fontSize: 20,color: Palette.secondaryColor),)),
              Container(margin:EdgeInsets.only(bottom: 16,left: 32),child: InkWell(onTap:(){},child: Text('Edit',style: TextStyle(fontSize: 16,color: Colors.blueAccent),))),
            ],
          ),

          Row(

            children: [

              Container(

                width: 400 ,

                child: TextFormField(

                  enabled: false,

                  decoration: InputDecoration(


                    labelText: 'First Name',

                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(4),

                    ),


                  ),

                ),
              ),

              Container(

                width: 400,


                margin: EdgeInsets.only(left: 32,right: 32),

                child: TextFormField(

                  decoration: InputDecoration(


                    enabled: false,

                    labelText: 'Last Name',

                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(4),

                    ),


                  ),

                ),
              ),



              RaisedButton(

                onPressed: (){},
                color: Palette.secondaryColor,

                child: Container(


                  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 64),
                  child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),

                ),

              ),


            ],

          ),

          Row(
            children: [
              Container(margin:EdgeInsets.only(bottom: 16,top: 48),child: Text('Email Address',style: TextStyle(fontSize: 20,color: Palette.secondaryColor),)),
              Container(margin:EdgeInsets.only(bottom: 16,left: 32,top: 48),child: InkWell(onTap:(){},child: Text('Edit',style: TextStyle(fontSize: 16,color: Colors.blueAccent),))),
            ],
          ),

          Row(

            children: [

              Container(

                width: 400 ,

                margin: EdgeInsets.only(right: 32),

                child: TextFormField(

                  enabled: false,

                  decoration: InputDecoration(


                    labelText: 'Email Address',

                    border: OutlineInputBorder(

                      borderRadius: BorderRadius.circular(4),

                    ),


                  ),

                ),
              ),

              RaisedButton(

                onPressed: (){},
                color: Palette.secondaryColor,

                child: Container(


                  padding: EdgeInsets.symmetric(vertical: 16,horizontal: 64),
                  child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),

                ),

              ),


            ],

          ),

          Row(
            children: [
              Container(margin:EdgeInsets.only(bottom: 16,top: 48),child: Text('Referral Code',style: TextStyle(fontSize: 20,color: Palette.secondaryColor),)),
              Container(margin:EdgeInsets.only(bottom: 16,left: 32,top: 48),child: Text('7 times used',style: TextStyle(fontSize: 16,color: Colors.blueAccent),)),
            ],
          ),

          Container(

            width: 400 ,

            height: 56,

            margin: EdgeInsets.only(right: 32),

            decoration: BoxDecoration(

              border: Border.all(color: Colors.grey[500]),
              
              borderRadius: BorderRadius.circular(4)

            ),

            alignment: Alignment.centerLeft,

            child: Row(

              children: [

                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: 12),

                    child: Text(

                      '1564564ADSADDV',
                      style: TextStyle(fontSize: 20),


                    ),
                  ),
                ),
                
                Container(

                  margin: EdgeInsets.only(right: 8),

                  child: IconButton(

                    icon: Icon(Icons.copy_outlined),
                    onPressed: (){},

                  ),
                )

              ],
            ),
          ),


        ],

      ),
    );

  }




}