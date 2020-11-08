import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Image(
        image: AssetImage('assets/images/logo.jpeg'),
      ),
    );
  }
}
