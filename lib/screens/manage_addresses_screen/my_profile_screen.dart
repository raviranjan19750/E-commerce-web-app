import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:living_desire/ProviderModels/MyProfileProvider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:provider/provider.dart';

class MyProfileScreen extends StatelessWidget{


  bool init = false;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => MyProfileProvider(),
        child: Consumer<MyProfileProvider>(
          builder: (BuildContext context, MyProfileProvider value, Widget child) {

            if (!init) {
              Provider.of<MyProfileProvider>(context, listen: false).initProle();
              init = true;
            }

            if(value.isInitialized)
              return Container(

              margin: EdgeInsets.all(32),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  Row(
                    children: [
                      Container(margin:EdgeInsets.only(bottom: 16),child: Text('Personal Information',style: TextStyle(fontSize: 20,color: Palette.secondaryColor),)),
                      Container(margin:EdgeInsets.only(bottom: 16,left: 32),child: InkWell(onTap:(){value.onNameEdit();},child: Text((value.isNameEdit)?'Cancel':'Edit',style: TextStyle(fontSize: 16,color: Colors.blueAccent),))),
                    ],
                  ),

                  Row(

                    children: [

                      Container(

                        width: 400 ,

                        margin: EdgeInsets.only(right: 32),

                        child: TextFormField(

                          controller: value.nameTextEditingController,

                          enabled: value.isNameEdit,

                          decoration: InputDecoration(


                            labelText: 'Username',

                            border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(4),

                            ),


                          ),

                        ),
                      ),


                      Visibility(

                        visible: value.isNameEdit,

                        child: RaisedButton(

                          onPressed: (){
                            value.onNameSave(context);
                          },
                          color: Palette.secondaryColor,

                          child: Container(


                            padding: EdgeInsets.symmetric(vertical: 16,horizontal: 64),
                            child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),

                          ),

                        ),
                      ),


                    ],

                  ),

                  Row(
                    children: [
                      Container(margin:EdgeInsets.only(bottom: 16,top: 48),child: Text('Email Address',style: TextStyle(fontSize: 20,color: Palette.secondaryColor),)),
                      Container(margin:EdgeInsets.only(bottom: 16,left: 32,top: 48),child: InkWell(onTap:(){value.onEmailEdit();},child: Text((value.isEmailEdit)?'Cancel':'Edit',style: TextStyle(fontSize: 16,color: Colors.blueAccent),))),
                    ],
                  ),

                  Row(

                    children: [

                      Container(

                        width: 400 ,

                        margin: EdgeInsets.only(right: 32),

                        child: TextFormField(

                          controller: value.emailTextEditingController,

                          enabled: value.isEmailEdit,

                          decoration: InputDecoration(


                            labelText: 'Email Address',

                            border: OutlineInputBorder(

                              borderRadius: BorderRadius.circular(4),

                            ),


                          ),

                        ),
                      ),

                      Visibility(

                        visible: value.isEmailEdit,

                        child: RaisedButton(

                          onPressed: (){
                            value.onEmailSave(context);
                          },
                          color: Palette.secondaryColor,

                          child: Container(


                            padding: EdgeInsets.symmetric(vertical: 16,horizontal: 64),
                            child: Text('Save',style: TextStyle(color: Colors.white,fontSize: 20),),

                          ),

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

                              (value.referralCode!=null)?value.referralCode:'1564564ADSADDV',
                              style: TextStyle(fontSize: 20),


                            ),
                          ),
                        ),

                        Container(

                          margin: EdgeInsets.only(right: 8),

                          child: IconButton(

                            splashRadius: 24,
                            icon: Icon(Icons.copy_outlined),
                            onPressed: (){

                              Clipboard.setData(new ClipboardData(text: value.referralCode));

                            },

                          ),
                        )

                      ],
                    ),
                  ),

                  Container(margin:EdgeInsets.only(top: 32),child: Text('Manage Address',style: TextStyle(fontSize: 24 ,color: Palette.secondaryColor,fontWeight: FontWeight.bold),)),

                ],

              ),
            );
            else
              return CircularProgressIndicator();

          },
        ));



  }




}