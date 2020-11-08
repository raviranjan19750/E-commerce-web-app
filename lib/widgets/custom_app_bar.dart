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
          AppBarLogo(),
          // WebSite Name
          AppBarWebName(),
          //Search Bar
          AppBarSearchBar(),
          // Cart
          AppBarCart(),
          // User Card Login/Signup or Profile
          UserCard(),
        ],
      ),
    );
  }
}
