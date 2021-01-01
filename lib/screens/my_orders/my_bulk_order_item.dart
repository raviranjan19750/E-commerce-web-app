import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/service/navigation_service.dart';


class MyBulkOrderItem extends StatelessWidget{

  List<BulkOrder> bulkOrdItems;
  int index;

  MyBulkOrderItem({this.bulkOrdItems,this.index});

  String sampleRequestedString(bool sampleRequested){

    if(sampleRequested){
      return "YES";
    }
    else{
      return "NO";

    }

  }

  String dateStringLabel(BulkOrder bulkOrder){

    if(bulkOrder.placedDate == null){
      return "Requested On : ";
    }
    
    return "Placed On : ";

  }
  
  String dateFormatter(BulkOrder bulkOrder){
    
    if(bulkOrder.placedDate == null){
      return new DateFormat.yMMMd().format(bulkOrder.requestDate);
    }

    return new DateFormat.yMMMd().format(bulkOrder.placedDate);
    
  }
  
  String idStringTag(BulkOrder bulkOrder){
    
    if(bulkOrder.orderID == null){
      return "Request ID : ";
    }
    
    return "Order ID : ";
    
  }
  
  String idStringValue(BulkOrder bulkOrder){

    if(bulkOrder.orderID == null){
      return bulkOrder.requestID;
    }

    return bulkOrder.orderID;
    
  }

  String downloadInvoiceType(BulkOrder bulkOrder){

    if(bulkOrder.orderInvoiceUrl == null){

      if(bulkOrder.sampleInvoiceUrl !=null){

        return "Download Sample Invoice";

      }
      
      return "";

    }
    
    return "Download Order Invoice";

  }
  
  String deliveryStatusTag(BulkOrder bulkOrder){
    
    if(bulkOrder.orderTracking!=null && bulkOrder.orderTracking.isEmpty){
      
      if(bulkOrder.sampleTracking!=null && bulkOrder.sampleTracking.isNotEmpty){
        
        return "Sample Delivery Status : ";
        
      }
      
      return "";
      
    }
    
    return "Order Delivery Status : ";
    
  }
  
  String productTitle(List<dynamic> productTypes){
    
    String result = "";
    
    for(int i=0;i<productTypes.length;i++){
      
      if(i == productTypes.length-1)
        result+= (productTypes.elementAt(i));
      else
        result+= (productTypes.elementAt(i) + ","); 
      
    }
    
    return result;
    
  }

  @override
  Widget build(BuildContext context) {

    BulkOrder bulkOrder = bulkOrdItems.elementAt(index);

    return Container(

      margin: EdgeInsets.only(left: 32,right: 48,top: 16,bottom: 16),
      
      decoration: BoxDecoration(
        
        border: Border.all(color: Colors.grey[500]),
        borderRadius: BorderRadius.circular(8)
        
      ),

      child: Column(

        children: [

          Container(

            decoration: BoxDecoration(color: Colors.grey[200]),

            child: Column(

              children: [

                Row(

                  children: [

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text(dateStringLabel(bulkOrder),style: TextStyle(color: Colors.grey[500])),),
                        Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text(dateFormatter(bulkOrder),style: TextStyle(color: Palette.secondaryColor),),),

                      ],

                    ),

                    /*Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text('Total :',style: TextStyle(color: Colors.grey[500])),),
                        Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text('Rs 2000',style: TextStyle(color: Palette.secondaryColor),),),

                      ],

                    ),*/

                    Tooltip(

                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0, 2),
                            blurRadius: 8,
                          )],

                      ),
                      padding: EdgeInsets.all(8),
                      textStyle: TextStyle(color: Palette.secondaryColor,fontSize: 18),
                      preferBelow: true,

                      message: bulkOrder.address + '\nPincode : ' + bulkOrder.pincode,

                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text('Ship to :',style: TextStyle(color: Colors.grey[500])),),
                          Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text(bulkOrder.name,style: TextStyle(color: Palette.secondaryColor),),),

                        ],

                      ),
                    ),

                    Expanded(child: Container(),),

                    Visibility(
                      
                      visible: (bulkOrder.sampleTracking!=null && bulkOrder.sampleTracking.isNotEmpty) || (bulkOrder.orderTracking!=null && bulkOrder.orderTracking.isNotEmpty),
                      
                      child: Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4) ,child: Text(deliveryStatusTag(bulkOrder),style: TextStyle(color: Colors.grey[500])),),
                          Container(margin:EdgeInsets.only(left: 32,bottom: 8) ,child: Text('On the Way',style: TextStyle(color: Palette.secondaryColor),),),

                        ],

                      ),
                    ),

                    Column(

                      crossAxisAlignment: CrossAxisAlignment.end,

                      children: [

                        Container(margin:EdgeInsets.only(left: 32,top: 8,bottom: 4,right: 32) ,child: Text('${idStringTag(bulkOrder)} ${idStringValue(bulkOrder)}',style: TextStyle(color: Colors.grey[500])),),

                        Visibility(

                          visible: (bulkOrder.sampleInvoiceUrl!=null || bulkOrder.orderInvoiceUrl!=null),

                          child: InkWell(

                             onTap: (){},

                              child: Container(

                                margin:EdgeInsets.only(left: 32,bottom: 8,right: 32) ,

                                child: Text(downloadInvoiceType(bulkOrder),textAlign: TextAlign.end,style: TextStyle(color: Colors.blueAccent),),

                              )

                          ),
                        ),

                      ],

                    ),


                  ],

                ),

              ],

            ),

          ),

          Container(height: 1,color: Colors.grey[500],),

          Row(

            children: [

              Container(


                margin: EdgeInsets.only(left: 32),

                child: Image(

                  height: 160,

                  width: 120,

                  image: AssetImage('assets/images/logo.jpeg'),

                ),

              ),

              Expanded(

                child: Container(

                  margin: EdgeInsets.only(left: 32,top: 16),

                  child: Column(

                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [

                      Row(
                        children: [
                          Expanded(child: Container(child: Text(productTitle(bulkOrder.productType),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.w100),),)),
                          Container(

                            margin: EdgeInsets.only(left: 48,right: 32),

                            child: InkWell(

                              onTap: (){},

                              child: Text('Need Help ?',style: TextStyle(decoration: TextDecoration.underline),),

                            ),
                          ),
                        ],
                      ),

                      Column(

                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [

                          Row(

                            children: [

                              Text('Sample Requested  :  '),
                              Text(sampleRequestedString(bulkOrder.isSampleRequested),style: TextStyle(color: (bulkOrder.isSampleRequested) ? Colors.green : Colors.redAccent,fontWeight: FontWeight.bold),),

                            ],

                          ),

                          Container(

                            margin: EdgeInsets.only(top: 16,bottom: 16),

                            child: InkWell(

                              onTap: (){

                                // Navigator.pushNamed(context,RoutesConfiguration.BULK_ORDER_QUOTATION,arguments: {'key' : bulkOrder.key});
                                locator<NavigationService>().navigateTo(RoutesConfiguration.BULK_ORDER_QUOTATION, queryParams: {"key": bulkOrder.key});

                              },

                              child: Container(

                                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

                                decoration: BoxDecoration(

                                  border: Border.all(color: Palette.secondaryColor),

                                ),

                                child: Text('View Quotation'),

                              ),

                            ),

                          ),

                        ],
                      ),


                    ],

                  ),
                ),

              ),

            ],

          ),

        ],
      ),

    );

  }



}