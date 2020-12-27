import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/configs.dart';
import 'package:provider/provider.dart';

class BulkOrderItem extends StatelessWidget{

  BulkOrderProvider value;

  String imageUrl;

  int index;


  BulkOrderItem({this.value,this.index,this.imageUrl});

  @override
  Widget build(BuildContext context) {


    return Column(
      children: [
        Card(

          elevation: value.elevation,
          color: (index == value.selectedType ) ? Palette.secondaryColor : Colors.grey[500],

          child: Image.network(imageUrl,width: 150*value.size,height: 200*value.size,)

        ),
        Container(

          margin: EdgeInsets.only(bottom: 8),

          child: Text(value.productTypeMap.keys.elementAt(index),),

        )
      ],
    );
  }



  }


