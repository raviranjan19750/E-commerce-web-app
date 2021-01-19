import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart_config/cart_config_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:badges/badges.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/service/navigation_service.dart';

class AppBarCart extends StatelessWidget {
  // App Bar Cart
  // TODO: Change into Stateful widget
  // TODO: Use stack to show no. of items in the cart
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 12, right: 8),
        child: FlatButton(
          onPressed: () {
            locator<NavigationService>().navigateTo(RoutesConfiguration.CART);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                BlocBuilder<CartConfigBloc, CartConfigState>(
                  builder: (context, state) {
                    return Badge(
                      badgeContent: Text(
                        state.totalItem.toString() ?? '0',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                      badgeColor: Palette.secondaryColor,
                      child: Icon(Icons.shopping_cart_outlined),
                    );
                  }
                ),
                Text(
                  '   Cart',
                  style: TextStyle(color: Palette.secondaryColor),
                )
              ],
            ),
          ),
        ));
  }
}
