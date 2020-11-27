import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_item.dart';
import 'package:provider/provider.dart';

class StepOneBlock extends StatelessWidget{

  bool init = false;

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

            return Visibility(

              visible: value.stepOneDone,

              child: InkWell(

                onTap: (){

                  value.onStepOneReverse();

                },

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

                  margin: EdgeInsets.only(top: 32),

                  child: Row(
                    children: [

                      Image(image: AssetImage('assets/images/logo.jpeg'),width: 80,height: 80,),

                      Container( margin: EdgeInsets.only(left: 16),child: Text('Selected Item',style: TextStyle(color: Colors.white,fontSize: 24),)),
                    ],
                  ),

                ),
              ),

              replacement: Column(

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

                    child: Text('Select Item',style: TextStyle(color: Colors.white,fontSize: 24),),

                  ),

                  Container(

                    width: double.infinity,
                    height: 240,

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


                    child: ListView.builder(

                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder:
                            (BuildContext context, int index) {
                          return Container(

                            padding: EdgeInsets.symmetric(horizontal: 16),

                            child: BulkOrderItem(),
                          );
                        }),



                  ),

                  Container(

                    margin: EdgeInsets.only(top: 16),

                    alignment: Alignment.centerLeft,

                    child: RaisedButton(

                      padding: EdgeInsets.only(left: 80,right: 80,top: 28,bottom: 28),

                      onPressed: (){

                        value.onStepOneDone();

                      },

                      color: Palette.secondaryColor,

                      child: Text('Continue',style: TextStyle(color: Colors.white,fontSize: 24),),

                    ),
                  ),



                ],

              ),

            );
          },
        ));



  }



}