import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:living_desire/widgets/app_bar/app_bar_wishlist.dart';
import 'package:living_desire/widgets/app_bar/middle_app_bar.dart';

import '../widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget with PreferredSizeWidget {
  bool visibleMiddleAppBar = true;
  bool visibleSubAppBar = true;

  double setAppBarHeight(bool visibleMiddleAppBar, bool visibleSubAppBar) {
    double size = 88;

    if (visibleMiddleAppBar) size = 136;

    return size;
  }

  CustomAppBar({this.visibleMiddleAppBar = true, this.visibleSubAppBar = true});

  // AppBar has a preferred Size, need to extend Preferred Size widget
  Size get preferredSize =>
      Size.fromHeight(setAppBarHeight(visibleMiddleAppBar, visibleSubAppBar));

  @override
  _CustomAppBarState createState() => _CustomAppBarState(
      visibleMiddleAppBar: visibleMiddleAppBar,
      visibleSubAppBar: visibleSubAppBar);
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool visibleMiddleAppBar;
  bool visibleSubAppBar;

  _CustomAppBarState({
    this.visibleMiddleAppBar,
    this.visibleSubAppBar,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              width: double.infinity,
              height: 88,
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
                  UserCard(
                    isLoggedIn: BlocProvider.of<SignInBloc>(context).isSignedIn,
                  ),
                ],
              ),
            ),
            Visibility(visible: visibleMiddleAppBar, child: MiddleAppBar())
          ],
        ),
        Positioned(
            right: -5,
            bottom: -32,
            child: Visibility(visible: visibleSubAppBar, child: SubAppBar())),
      ],
    );
  }
}

class MyAppBar extends StatelessWidget {
  var rng = new Random();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        AppBarCart(),
        AppBarWishlist(),
        UserCard(
          isLoggedIn: BlocProvider.of<SignInBloc>(context).isSignedIn,
        ),
      ],
    );
  }
}
