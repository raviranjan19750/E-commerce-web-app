
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/palette.dart';
import 'package:living_desire/models/product_type.dart';

class ProductTypeBar extends StatelessWidget {

 final String productType ;

  const ProductTypeBar({Key key, this.productType}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Container(
          margin: EdgeInsets.only(top: 24.0),
          child: Divider(
            color: Colors.black,
            thickness: 0.5,
          ),
        ),

        Container(
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Palette.maroon,
          ),
          child: Text(
            productType,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white),
          ),
        ),

      ],
    );
    throw UnimplementedError();
  }

}