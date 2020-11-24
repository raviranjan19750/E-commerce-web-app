import 'package:flutter/material.dart';
import '../../config/configs.dart';

class AppBarWebName extends StatelessWidget {
  @override
  // AppBar WebSite Name
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        Strings.websiteName,
        style: const TextStyle(
          color: Palette.secondaryColor,
          fontSize: 32.0,
          fontWeight: FontWeight.bold,
          letterSpacing: -1.2,
        ),
      ),
    );
  }
}
