import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bullets extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: EdgeInsets.all(0.0),
      height: 7.0,
      width: 7.0,
      decoration: new BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
      ),
    );
  }
}