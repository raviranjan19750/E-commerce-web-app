import 'package:flutter/material.dart';
import '../config/configs.dart';

class UserCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Configure with firebase user login/signup
    return Container(
      child: RaisedButton(
        onPressed: () {},
        child: Text(Strings.loginText),
      ),
    );
  }
}
