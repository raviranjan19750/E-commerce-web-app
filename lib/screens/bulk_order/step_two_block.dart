import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/palette.dart';
import 'package:provider/provider.dart';

class StepTwoBlock extends StatelessWidget{
  bool init = false;

  List <String> spinnerItems = [
    'One',
    'Two',
    'Three',
    'Four',
    'Five'
  ] ;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => BulkOrderProvider(),
        child: Consumer<BulkOrderProvider>(
          builder: (BuildContext context, BulkOrderProvider value, Widget child) {

            if (!init) {
              Provider.of<BulkOrderProvider>(context, listen: false);
              init = true;
            }

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

                  child: Text('Select Customization',style: TextStyle(color: Colors.white,fontSize: 24),),

                ),

                Visibility(

                  visible: false,

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

                                  ListView.builder(

                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 15,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(

                                          onTap: (){},

                                          child: Container(

                                            margin: EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                                            width: 32.0,
                                            height: 32.0,
                                            decoration: new BoxDecoration(
                                              color: Colors.redAccent,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        );
                                      })

                                ],

                              ),
                            ),

                            Row(

                              children: [

                                InkWell(

                                  onTap: (){},

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

                                        Text('  Size : s',style: TextStyle(color: Palette.secondaryColor),),

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

                                        onPressed: (){},

                                        icon: Icon(

                                          Icons.remove,

                                        ),
                                      ),

                                      Text(' 32 ',style: TextStyle(color: Palette.secondaryColor),),

                                      IconButton(

                                        onPressed: (){},

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



                          },

                          color: Palette.secondaryColor,

                          child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 24),),

                        ),
                      ),
                    ],
                  ),

                  replacement: Container(

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

                    child: Column(


                      children: [

                        Container(

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

                                    Text(' Qty : ',style: TextStyle(color: Palette.secondaryColor),),

                                    Text(' 32 ',style: TextStyle(color: Palette.secondaryColor),),


                                  ],

                                ),

                              )

                            ],

                          ),
                        ),

                      ],
                    ),

                  ),

                )
              ],
            );
          },
        ));

  }



}