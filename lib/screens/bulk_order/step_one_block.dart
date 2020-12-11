import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_item.dart';
import 'package:provider/provider.dart';

class StepOneBlock extends StatelessWidget{

  final String productType, productSubType;
      
  StepOneBlock({this.productType,this.productSubType});
  
  bool init = false;

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => BulkOrderProvider(),
        child: Consumer<BulkOrderProvider>(
          builder: (BuildContext context, BulkOrderProvider value, Widget child) {

            if (!init) {
              Provider.of<BulkOrderProvider>(context, listen: false).initStepOne(productType, productSubType);
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
                          return InkWell(

                            onTap: (){

                              value.onProductTypeSelected();

                              print("called");

                            },

                            child: Container(

                              padding: EdgeInsets.symmetric(horizontal: 16),

                              child: BulkOrderItem(),
                            ),
                          );
                        }),



                  ),

                  Visibility(

                    visible: value.productTypeSelected,

                    child: Container(

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
                            
                            margin: EdgeInsets.only(left: 16,top: 8,bottom: 8),
                            
                            width:double.infinity ,
                            alignment: Alignment.centerLeft,
                            child: Text('Select Sub Type',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),),

                          GridView.builder(
                            shrinkWrap: true,
                            itemCount: 8,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 6,

                                childAspectRatio: MediaQuery.of(context).size.width /
                                  (MediaQuery.of(context).size.height / 2),

                            ),

                                  itemBuilder: (BuildContext context, int index) {

                                    return InkWell(

                                      onTap: (){},

                                      child: new Container(

                                        alignment: Alignment.center,

                                        margin: EdgeInsets.all(8),

                                        decoration: BoxDecoration(

                                          border: Border.all(color: Palette.secondaryColor),

                                          borderRadius: BorderRadius.circular(4),

                                          color: Colors.white

                                        ),

                                        child: Text('SubType',style: TextStyle(fontSize: 16),),

                                      ),
                                    );

                              },
                          ),
                        ]
                      ),

                    ),
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