import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class AppBarWishlist extends StatelessWidget {
  // App Bar Cart
  // TODO: Change into Stateful widget
  // TODO: Use stack to show no. of items in the cart
  @override
  Widget build(BuildContext context) {
    return Container(

        margin: EdgeInsets.only(right: 12),

        child: FlatButton(

          onPressed: (){},

          child: Container(

            padding: EdgeInsets.all(8),

            child: Row(

              children: [

                Icon(

                  Icons.favorite_border,
                  color: Palette.secondaryColor,

                ),


                Text('  Wishlist',

                  style: TextStyle(color: Palette.secondaryColor),

                )

              ],

            ),
          ),
        )
    );
  }
}
