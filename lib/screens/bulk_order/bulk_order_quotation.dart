import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';


class BulkOrderQuotation extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: CustomAppBar(size: 140,visibleSubAppBar: true,visibleMiddleAppBar: true,),

      body: SingleChildScrollView(

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [

              Container(


                margin: EdgeInsets.only(left: 64,right: 64,top: 120),

                width: double.infinity,

                height: 1,

                color: Colors.grey[500],

              ),

              Container(

                color: Colors.redAccent,

                margin: EdgeInsets.only(left: 64,top: 4),

                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                child: Text('Quotation',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),

              ),

              Container(

                decoration: BoxDecoration(

                  border : Border.all(color: Colors.grey[500]),
                  borderRadius: BorderRadius.circular(8)

                ),

                margin: EdgeInsets.only(left: 64,top: 64),

                child: DataTable(

                  headingRowColor:  MaterialStateColor.resolveWith((states) => Colors.grey[200]),

                  dividerThickness: 2,



                  dataRowHeight: 80,

                  columns: [

                    DataColumn(

                      label: Text('Image',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

                    ),
                    DataColumn(

                      label: Text('Product Name',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

                    ),
                    DataColumn(

                      label: Text('Quantity',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

                    ),
                    DataColumn(

                      label: Text('Price per Item',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

                    ),
                    DataColumn(

                      label: Text('Price',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

                    ),

                  ],

                  rows: [
                    DataRow(

                      cells: [

                        DataCell(Image(image: AssetImage('assets/images/logo.jpeg'),height: 64,width: 64,)),
                        DataCell(Text('Classic Filled Bean Bag with Beans')),
                        DataCell(Text('100')),
                        DataCell(Text('10')),
                        DataCell(Text('1000')),


                      ]
                    ),
                    DataRow(

                        cells: [

                          DataCell(Image(image: AssetImage('assets/images/logo.jpeg'),height: 64,width: 64,)),
                          DataCell(Text('Classic Filled Bean')),
                          DataCell(Text('10')),
                          DataCell(Text('10')),
                          DataCell(Text('100')),


                        ]
                    ),
                    DataRow(

                        cells: [

                          DataCell(Image(image: AssetImage('assets/images/logo.jpeg'),height: 64,width: 64,)),
                          DataCell(Text('Classic Filled Bean Bag with Beans')),
                          DataCell(Text('100')),
                          DataCell(Text('10')),
                          DataCell(Text('1000')),


                        ]
                    ),
                    DataRow(

                        cells: [

                          DataCell(Image(image: AssetImage('assets/images/logo.jpeg'),height: 64,width: 64,)),
                          DataCell(Text('Classic Filled Bean Bag with Beans')),
                          DataCell(Text('100')),
                          DataCell(Text('10')),
                          DataCell(Text('1000')),


                        ]
                    ),

                  ],

                ),
              ),

              Container(

                margin: EdgeInsets.only(left: 64,top: 16),

                child: Row(

                  children: [

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,


                    children: [

                      Row(
                        children: [
                          Text('Quotation Status ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                          Text('    Received',style: TextStyle(color: Colors.green,fontSize: 22),),
                        ],
                      ),

                      Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                      Row(
                        children: [
                          Text('Date of Order ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                          Text('        12/12/2020 7:45',style: TextStyle(color: Palette.secondaryColor,fontSize: 22),),
                        ],
                      ),

                      Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                      Row(
                        children: [
                          Text('Sample Requested ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                          Text('  NO',style: TextStyle(color: Palette.secondaryColor,fontSize: 22),),
                        ],
                      ),

                      Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                    ]
                  ),

                    Container(

                      margin: EdgeInsets.only(left: 200),

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.center,

                        children: [

                          Row(

                            children: [

                              Text('Sub Total : ',style: TextStyle(fontSize: 20,color: Colors.grey[500],),),
                              Text('   ₹ 3000',style: TextStyle(fontSize: 22,color: Colors.black),)

                            ],

                          ),

                          Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                          RaisedButton(

                            onPressed: (){},

                            color: Palette.secondaryColor,

                            child: Container(

                              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),

                              child:Text('Check Out',style: TextStyle(color: Colors.white),),

                            ),

                          ),

                          Padding(padding: EdgeInsets.symmetric(vertical: 12),),

                          FlatButton(

                            onPressed: (){},

                            child: Container(


                              padding: EdgeInsets.symmetric(horizontal: 32,vertical: 16),

                              decoration: BoxDecoration(

                                border: Border.all(color: Palette.secondaryColor)

                              ),

                              child:Text('Continue Shopping',style: TextStyle(color: Palette.secondaryColor),),

                            ),

                          ),

                        ],

                      ),
                    )
                ],

                ),
              )

          ],

        ),

      ),

    );


  }




}