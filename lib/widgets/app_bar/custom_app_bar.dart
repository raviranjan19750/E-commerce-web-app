import 'package:living_desire/widgets/app_bar/app_bar_wishlist.dart';

import '../widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  // AppBar has a preferred Size, need to extend Preferred Size widget
  Size get preferredSize => const Size.fromHeight(120.0);
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),

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
              AppBarSearchBar(),
              // Cart
              AppBarCart(),

              AppBarWishlist(),
              // User Card Login/Signup or Profile
              UserCard(),
            ],
          ),
        ),
        SubAppBar()
      ],
    );
  }
}
