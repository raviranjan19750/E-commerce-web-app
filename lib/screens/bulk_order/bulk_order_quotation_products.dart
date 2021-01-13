import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/models/BulkOrder.dart';
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';

class BulkOrderQuotationProducts extends StatelessWidget{

  BulkOrder bulkOrder;

  BulkOrderQuotationProducts({this.bulkOrder});

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

    return Column(

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [

        Container(


          margin: EdgeInsets.only(left: 64,right: 64,top: 32),

          width: double.infinity,

          height: 1,

          color: Colors.grey[500],

        ),

        Container(

          margin: EdgeInsets.only(left: 48),

          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),

          child: LabelTag('Quotation   '),

        ),

        Container(

          decoration: BoxDecoration(

              border : Border.all(color: Colors.grey[500]),
              borderRadius: BorderRadius.circular(8)

          ),

          margin: EdgeInsets.only(left: 64,top: 32),

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

                label: Text('Color',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

              ),

              DataColumn(

                label: Text('Size',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

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

            rows: bulkOrder.products
                .map(
                  (quotationProduct) => DataRow(cells: [
                DataCell(Image(image: AssetImage('assets/images/logo.jpeg'),height: 64,width: 64,)),
                DataCell(Text(quotationProduct.productType+'    '+quotationProduct.productSubType)),
                DataCell(Container(

                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  width: 24.0,
                  height: 24.0,
                  decoration: new BoxDecoration(
                    color: HexColorConvert.fromHex(quotationProduct.colour.first['hexCode']),
                    shape: BoxShape.circle,
                  ),
                ),),
                DataCell(Text(quotationProduct.size)),
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

          child:  Column(

              crossAxisAlignment: CrossAxisAlignment.start,


              children: [

                Row(
                  children: [

                    Text('Quotation Status ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                    Text('    '+ bulkOrder.quotationTracking.first.statusValue ,style: TextStyle(color: Colors.green,fontSize: 22),),
                  ],
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                Row(
                  children: [
                    Text('Date of Order ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                    Text('        '+dateFormatter(bulkOrder),style: TextStyle(color: Palette.secondaryColor,fontSize: 22),),
                  ],
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: 6),),

                Row(
                  children: [
                    Text('Sample Requested ',style: TextStyle(color: Colors.grey[500],fontSize: 20),),

                    Text('  '+ sampleRequestedString(bulkOrder.isSampleRequested),style: TextStyle(color: Palette.secondaryColor,fontSize: 22),),
                  ],
                ),

                Padding(padding: EdgeInsets.symmetric(vertical: 6),),

              ]
          ),
        )

      ],

    );

  }



}