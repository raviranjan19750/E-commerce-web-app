import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:living_desire/ProviderModels/bulk_order_quotation_provider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/widgets/app_bar/custom_app_bar.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';
import 'package:provider/provider.dart';


class BulkOrderQuotation extends StatelessWidget{

  String id;

  bool init = false;

  BulkOrderQuotation({this.id});

  String totalPrice(int price,int quantity){

    int ans = price * quantity;

    return ans.toString();

  }

  String dateFormatter(BulkOrder bulkOrder){

    if(bulkOrder.placedDate == null){
      return new DateFormat.yMMMd().format(bulkOrder.requestDate);
    }

    return new DateFormat.yMMMd().format(bulkOrder.placedDate);

  }

  String sampleRequestedString(bool sampleRequested){

    if(sampleRequested){
      return "YES";
    }
    else{
      return "NO";

    }

  }

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
        lazy: false,
        create: (context) => BulkOrderQuotationProvider(),
        child: Consumer<BulkOrderQuotationProvider>(
          builder: (BuildContext context, BulkOrderQuotationProvider value, Widget child) {

            if (!init) {
              Provider.of<BulkOrderQuotationProvider>(context, listen: false).initQuotation(id);
              init = true;
            }

            return Scaffold(

              appBar: CustomAppBar(size: 140,visibleSubAppBar: true,visibleMiddleAppBar: true,),

              body: (value.bulkOrder != null) ?SingleChildScrollView(

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

                      margin: EdgeInsets.only(left: 16),

                      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                      child: LabelTag('Quotation   '),

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

                        rows: value.bulkOrder.products
                            .map(
                              (quotationProduct) => DataRow(cells: [
                                DataCell(Image(image: AssetImage('assets/images/logo.jpeg'),height: 64,width: 64,)),
                                DataCell(Text(quotationProduct.productSubType)),
                                DataCell(Text(quotationProduct.quantity.toString())),
                                DataCell(Text(
                                    ((quotationProduct.discountPrice!=null)?quotationProduct.discountPrice.toString():'-'),

                                )
                                ),
                                DataCell(Text( ((quotationProduct.discountPrice!=null)?totalPrice(quotationProduct.discountPrice, quotationProduct.quantity):'-'))),
                          ]),
                        )
                            .toList(),

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

                                    Text('    '+ value.bulkOrder.quotationTracking.first.statusValue ,style: TextStyle(color: Colors.green,fontSize: 22),),
                                  ],
                                ),

                                Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                                Row(
                                  children: [
                                    Text('Date of Order ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                                    Text('        '+dateFormatter(value.bulkOrder),style: TextStyle(color: Palette.secondaryColor,fontSize: 22),),
                                  ],
                                ),

                                Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                                Row(
                                  children: [
                                    Text('Sample Requested ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                                    Text('  '+ sampleRequestedString(value.bulkOrder.isSampleRequested),style: TextStyle(color: Palette.secondaryColor,fontSize: 22),),
                                  ],
                                ),

                                Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                              ]
                          ),

                          Visibility(

                            visible: (value.bulkOrder.quotationStatus != 101),

                            child: Container(

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
                            ),
                          )
                        ],

                      ),
                    )

                  ],

                ),

              ) : Center(child: CircularProgressIndicator(),),

            );

          },
        ));




  }




}