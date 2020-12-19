import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/wishlist_config/wishlist_bloc.dart';
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

                BlocBuilder<WishlistConfigBloc, WishlistConfigState>(
                  builder: (context, state) {
                    return Badge(
                      badgeContent: Text(state.totalItem.toString(),style: TextStyle(color: Colors.white,fontSize: 12),),
                      badgeColor: Palette.secondaryColor,
                      child: Icon(Icons.favorite_border),
                    );
                  },
                ),


                Text('     Wishlist',

                  style: TextStyle(color: Palette.secondaryColor),

                )

              ],

            ),
          ),
        )
    );
  }
}
