import 'dart:html';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:living_desire/ProviderModels/bulk_order_provider.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/models/uploadImage.dart';

class UploadLogo extends StatelessWidget{

  BulkOrderProvider value;

  List<UploadImage> logos;

  int index, size;

  UploadLogo({this.index,this.size,this.logos,this.value});

  @override
  Widget build(BuildContext context) {

    if(index != size-1){

      return Stack(

        alignment: Alignment.topRight,

        children: [

          Card(

            elevation: 8,
            color: Palette.secondaryColor,

            child: Image.memory(logos.elementAt(index).uri,height: 160,width: 120,),

          ),

          IconButton(

            onPressed: (){

              value.deleteImage(index);

            },

            icon: Icon(Icons.highlight_remove_outlined,color: Colors.redAccent,),

          )
        ],
      );

    }
    else{

      return Container(

        width: 120,
        height: 160,

        child: Card(

          elevation: 8,
          color: Colors.white,

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              Container(

                child: Icon(Icons.add,size: 64,),


              ),

              Text('Add More',style: TextStyle(color: Colors.orange),textAlign: TextAlign.center,)
            ],
          )

        ),
      );

    }

  }



}