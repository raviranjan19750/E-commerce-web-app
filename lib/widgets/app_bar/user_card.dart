import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/screens/login/login.dart';
import 'package:living_desire/service/authentication_service.dart';
import '../../config/configs.dart';

class UserCard extends StatefulWidget {
  bool isLoggedIn = false;
  String userName, phoneNumber;

  UserCard({this.isLoggedIn, this.userName, this.phoneNumber});
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  User user;
  FirebaseAuth _auth;

  @override
  void initState() {
    user = FirebaseAuth.instance.currentUser;

    print("current state " + user.toString());
    // print(user.toString() + "Current state");
    super.initState();
  }

  void _showLoginDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoginScreen();
        });
  }

  void _showPopupMenu(BuildContext context, Offset offset) async {
    await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(offset.dx, offset.dy + 16, 64, 0),
      items: [
        PopupMenuItem(
          child: Text("My Account"),
        ),
        PopupMenuItem(
          child: Text("My Orders"),
        ),
        PopupMenuItem(
          child: Text("My Cart"),
        ),
        PopupMenuItem(
          child: Text("My Wishlist"),
        ),
        PopupMenuItem(
          child: InkWell(
            child: Text("Sign Out"),
            onTap: () {
              RepositoryProvider.of<AuthenticationRepository>(context).logout();
            },
          ),
        ),
      ],
      elevation: 8.0,
    );
  }

  Container returnView(bool loggedIn, BuildContext context) {
    if (loggedIn) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                blurRadius: 12.0,
                offset: Offset(0, 0.75)),
          ],
          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: InkWell(
          onTap: () {},
          child: GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(context, details.globalPosition);
            },
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Login as Vardaan Chakraborty',
                      style: TextStyle(color: Palette.primaryColor),
                    ),
                    Text(
                      '8617878497',
                      style: TextStyle(color: Palette.primaryColor),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(left: 16),
                  child: Icon(
                    Icons.arrow_drop_down,
                    color: Palette.primaryColor,
                    size: 48,
                  ),
                )
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Palette.secondaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        // Login Button
        child: InkWell(
          onTap: () {
            _showLoginDialog(context);
          },
          child: Text(
            Strings.loginText,
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      print("user state" +
          state.user.toString() +
          "state.status" +
          state.status.toString());
      switch (state.status) {
        case AuthenticationStatus.authenticated:
          return returnView(true, context);
        case AuthenticationStatus.unauthenticated:
        default:
          return returnView(false, context);
      }
    });
  }
}
