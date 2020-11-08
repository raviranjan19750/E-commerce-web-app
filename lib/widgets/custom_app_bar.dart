import '../config/configs.dart';
import '../widgets/widgets.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  // AppBar has a preferred Size, need to extend Preferred Size widget
  Size get preferredSize => const Size.fromHeight(65.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: double.infinity,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Logo of the website
          Expanded(
            child: Image(
              image: AssetImage('assets/images/logo.jpeg'),
            ),
          ),
          // WebSite Name
          Expanded(
            child: Text(
              Strings.websiteName,
              style: const TextStyle(
                color: Palette.secondaryColor,
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
                letterSpacing: -1.2,
              ),
            ),
          ),
          //Search Bar
          Expanded(
            child: Container(),
          ),
          // Cart
          Expanded(
            child: Container(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                iconSize: 30.0,
                onPressed: () {},
              ),
            ),
          ),
          // User Card Login/Signup or Profile
          UserCard(),
        ],
      ),
    );
  }
}
