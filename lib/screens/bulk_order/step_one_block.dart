import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_item.dart';
import 'package:provider/provider.dart';

class StepOneBlock extends StatelessWidget{

  final String productType, productSubType;

  BulkOrderProvider value;

  StepOneBlock({this.productType,this.productSubType,this.value});
  
  bool init = false;

  @override
  Widget build(BuildContext context) {

    return  Visibility(

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

              Image.network((value.selectedType != -1) ?value.productTypeImages.elementAt(value.selectedType) : "",width: 80,height: 80,),

              Container( margin: EdgeInsets.only(left: 16),child: Text(value.bulkOrderCart.productType,style: TextStyle(color: Colors.white,fontSize: 24),)),

              Container( margin: EdgeInsets.only(left: 16),child: Text(value.bulkOrderCart.productSubType,style: TextStyle(color: Colors.white,fontSize: 24),)),
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
            height: 0.25 * MediaQuery.of(context).size.height,

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


            child: Visibility(

              visible: value.onDataLoaded,

              replacement: Center(child: CircularProgressIndicator(),),

              child: ListView.builder(

                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: value.productTypeMap.keys.length,
                  itemBuilder:
                      (BuildContext context, int index) {
                    return InkWell(

                      onTap: (){

                        value.onProductTypeSelected(index);

                      },

                      child: Container(

                        padding: EdgeInsets.symmetric(horizontal: 16),

                        child: BulkOrderItem(value: value,index: index,imageUrl: value.productTypeImages.elementAt(index),),
                      ),
                    );
                  }),
            ),



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
                      child: Text('Select Sub Type',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),),

                    GridView.builder(
                      shrinkWrap: true,
                      itemCount: value.subTypes.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 6,

                        childAspectRatio: MediaQuery.of(context).size.width /
                            (MediaQuery.of(context).size.height / 2),

                      ),

                      itemBuilder: (BuildContext context, int index) {

                        return InkWell(

                          onTap: (){

                            value.onProductSubTypeSelected(index);

                          },

                          child: new Container(

                            alignment: Alignment.center,

                            margin: EdgeInsets.all(8),

                            decoration: BoxDecoration(

                                border: Border.all(color: Palette.secondaryColor),

                                borderRadius: BorderRadius.circular(4),

                                color: (index == value.selectedSubType) ? Palette.secondaryColor : Colors.white

                            ),

                            child: Text(value.subTypes.elementAt(index),style: TextStyle(fontSize: 14 ,color: (index == value.selectedSubType) ? Colors.white :Palette.secondaryColor),),

                          ),
                        );

                      },
                    ),
                  ]
              ),

            ),
          ),

          Visibility(

            visible: value.productTypeSelected && value.productSubTypeSelected,

            child: Container(

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
          ),



        ],

      ),

    );



  }



}