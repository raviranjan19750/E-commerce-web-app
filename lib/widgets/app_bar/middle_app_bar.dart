import 'package:flutter/rendering.dart';
import 'package:living_desire/widgets/app_bar/app_bar_wishlist.dart';

import '../widgets.dart';
import 'package:flutter/material.dart';

class MiddleAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Container(

      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 4),
      height: 48,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 4.0,
          ),
        ],
      ),

      child : ListView.builder(

            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: 15,
            itemBuilder:
                (BuildContext context, int index) {
              return Container(

                padding: EdgeInsets.symmetric(horizontal: 16),

                child: FlatButton(

                  onPressed: (){},

                  child: Text('Bean Bags'),

                ),
              );
            })


    );


  }



}