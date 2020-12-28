import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/palette.dart';
import 'package:provider/provider.dart';

class StepTwoBlock extends StatelessWidget{


  BulkOrderProvider value;

  StepTwoBlock({this.value});


  void _showPopupMenu(BuildContext context,Offset offset) async {
    await showMenu(

      context: context,

      position: RelativeRect.fromLTRB(-offset.dx , offset.dy ,0,0),
      items: [
        PopupMenuItem(
          child: FlatButton(

            onPressed: (){

              value.onItemSizeChanged("S");
              Navigator.of(context).pop();

            },

              child: Text("S")),
        ),
        PopupMenuItem(
          child: FlatButton(

              onPressed: (){

                value.onItemSizeChanged("M");
                Navigator.of(context).pop();

              },

              child: Text("M")),
        ),
        PopupMenuItem(
          child: FlatButton(

              onPressed: (){

                value.onItemSizeChanged("L");
                Navigator.of(context).pop();

              },

              child: Text("L")),
        ),
        PopupMenuItem(
          child: FlatButton(

              onPressed: (){

                value.onItemSizeChanged("XL");
                Navigator.of(context).pop();

              },

              child: Text("XL")),
        ),
        PopupMenuItem(
          child: FlatButton(

              onPressed: (){

                value.onItemSizeChanged("XXL");
                Navigator.of(context).pop();

              },

              child: Text("XXL")),
        ),
      ],
      elevation: 8.0,
    );
  }

  @override
  Widget build(BuildContext context) {

    return  Column(

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

          child: Text('Select Customization',style: TextStyle(color: Colors.white,fontSize: 24),),

        ),

        Visibility(

          visible: value.stepOneDone && !value.stepTwoDone,

          child: Column(

            children: [

              Container(

                width: double.infinity,

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

                child: Column(


                  children: [

                    Container(

                      height: 80,

                      child: Row(

                        children: [

                          Text('Select Color : ',style: TextStyle(color: Palette.secondaryColor,fontSize: 18),),

                          RaisedButton(

                              onPressed: (){

                                value.showColorPicker(context);

                              },

                              color: value.currentColor,


                          ),

                        ],

                      ),
                    ),

                    Row(

                      children: [

                        GestureDetector(

                          onTapDown: (TapDownDetails details){

                              _showPopupMenu(context, details.globalPosition);

                          },

                          child: Container(


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
                            padding: EdgeInsets.all(8),

                            child: Row(

                              children: [

                                Row(

                                  children: [

                                    Text('  Size : ',style: TextStyle(color: Palette.secondaryColor),),
                                    Text(value.itemSize,style: TextStyle(color: Palette.secondaryColor),),

                                  ],

                                ),

                                Padding(
                                  padding: EdgeInsets.all(8),

                                  child: Icon(
                                    Icons.arrow_drop_down,

                                  ),
                                )

                              ],

                            ),

                          ),
                        ),

                        Container(

                          margin: EdgeInsets.only(left: 32),
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
                          padding: EdgeInsets.all(8),

                          child: Row(

                            children: [

                              Text('  Qty : ',style: TextStyle(color: Palette.secondaryColor),),

                              IconButton(

                                onPressed: (){

                                  value.decrementQuantity(60);

                                },

                                icon: Icon(

                                  Icons.remove,

                                ),
                              ),


                              Container(
                                width: 36,

                                child: TextFormField(

                                  textAlign: TextAlign.center,
                                  autofocus: false,

                                  keyboardType: TextInputType.number,
                                  controller: value.quantityController,

                                  validator: (input) {
                                    final isDigitsOnly = int.tryParse(input);
                                    return isDigitsOnly == null
                                        ? 'Input needs to be digits only'
                                        : null;
                                  },

                                  onChanged: (s){

                                    value.quantity = int.tryParse(s);

                                  },

                                  decoration: InputDecoration(

                                      border: InputBorder.none

                                  ),
                                ),

                              ),

                              IconButton(

                                onPressed: (){

                                  value.incrementQuantity(60);

                                },

                                icon: Icon(

                                  Icons.add,

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

              Container(

                margin: EdgeInsets.only(top: 16,bottom: 16),

                alignment: Alignment.centerLeft,

                child: RaisedButton(

                  padding: EdgeInsets.only(left: 80,right: 80,top: 28,bottom: 28),

                  onPressed: (){

                      value.onStepTwoDone();

                  },

                  color: Palette.secondaryColor,

                  child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 24),),

                ),
              ),
            ],
          ),

        ),

        Visibility(

          visible: value.stepTwoDone,

          child: Container(

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

            child: Container(

              height: 80,

              child: Row(

                children: [

                  Text('Color : ',style: TextStyle(color: Colors.white,fontSize: 18),),

                  Container(

                    margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                    width: 32.0,
                    height: 32.0,
                    decoration: new BoxDecoration(
                      color: Colors.redAccent,
                      shape: BoxShape.circle,
                    ),
                  ),

                  Container(


                    margin: EdgeInsets.only(left: 16),

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
                    padding: EdgeInsets.all(8),

                    child: Text('Size : s',style: TextStyle(color: Palette.secondaryColor),),

                  ),

                  Container(

                    margin: EdgeInsets.only(left: 32),
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
                    padding: EdgeInsets.all(8),

                    child: Row(

                      children: [

                        Text(' Qty :  ',style: TextStyle(color: Palette.secondaryColor),),

                        Text( value.quantity.toString() + " ",style: TextStyle(color: Palette.secondaryColor),),

                      ],

                    ),

                  )

                ],

              ),
            ),

          ),

        )
      ],
    );

  }



}