import 'package:living_desire/widgets/app_bar/app_bar_wishlist.dart';
import 'package:living_desire/widgets/app_bar/middle_app_bar.dart';

import '../widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  // AppBar has a preferred Size, need to extend Preferred Size widget
  Size get preferredSize => const Size.fromHeight(110.0);
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      // clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 16,right: 16,top: 8),

              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 4.0,
                  ),
                ],
              ),
              child: Row(

                crossAxisAlignment: CrossAxisAlignment.center,

                children: [

                  //Logo of the website
                  AppBarLogo(),
                  // WebSite Name
                  AppBarWebName(),
                  //Search Bar
                  Expanded(child: AppBarSearchBar()),
                  // Cart
                  AppBarCart(),

                  AppBarWishlist(),
                  // User Card Login/Signup or Profile
                  UserCard(isLoggedIn: false,
                  ),
                ],
              ),
            ),
            MiddleAppBar()
          ],
        ),
        Positioned(
          right: 0,
          bottom: -23,
          child: SubAppBar(),
        ),
      ],
    );
  }
}
