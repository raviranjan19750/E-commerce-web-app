import 'package:flutter/material.dart';
import '../../config/configs.dart';

class AppBarWebName extends StatelessWidget {
  @override
  // AppBar WebSite Name
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      child: Text(
        Strings.websiteName,
        style: const TextStyle(
          color: Palette.secondaryColor,
          fontSize: 20,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
