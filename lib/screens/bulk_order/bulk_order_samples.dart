import 'package:flutter/material.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/models/StringToHexColor.dart';
import 'package:living_desire/models/samples.dart';
import 'package:living_desire/widgets/home_screen_widget/home_product.dart';

class BulkOrderSamples extends StatelessWidget{


  List<Samples> sampleList;

  BulkOrderSamples({this.sampleList});

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

          child: LabelTag('Samples   '),

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

                label: Text('Sample Price',style: TextStyle(color:Palette.secondaryColor ,fontSize: 16,fontWeight: FontWeight.bold,),),

              ),


            ],

            rows: sampleList
                .map(
                  (sample) => DataRow(cells: [
                DataCell(Image(image: AssetImage('assets/images/logo.jpeg'),height: 64,width: 64,)),
                DataCell(Text(sample.productType+'    '+sample.productSubtype)),
                DataCell(Container(

                  margin: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                  width: 24.0,
                  height: 24.0,
                  decoration: new BoxDecoration(
                    color: HexColorConvert.fromHex(sample.color),
                    shape: BoxShape.circle,
                  ),
                ),),
                DataCell(Text(sample.size)),
                DataCell(Text(sample.quantity.toString())),
                DataCell(Text(
                  ((sample.discountPrice!=null)?sample.discountPrice.toString():'-'),

                )
                ),
              ]),
            )
                .toList(),

          ),
        ),

      ],

    );

  }




}