import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class AppBarCart extends StatelessWidget {
  // App Bar Cart
  // TODO: Change into Stateful widget
  // TODO: Use stack to show no. of items in the cart
  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(left: 12,right: 8),

      child: FlatButton(

        onPressed: (){},

        child: Container(

          padding: EdgeInsets.all(8),
          
          child: Row(

            children: [

              Icon(

                Icons.shopping_cart_outlined,
                color: Palette.secondaryColor,

              ),


              Text('  Cart',

                style: TextStyle(color: Palette.secondaryColor),

              )

            ],

          ),
        ),
      )
    );
  }
}
