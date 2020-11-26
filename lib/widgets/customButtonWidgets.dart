import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/strings.dart';

// ignore: must_be_immutable
class CustomWidgetButton extends StatelessWidget {

  final VoidCallback onPressed;
  final Color backGroundColor;
  final Color textColor;
  final String text;

  const CustomWidgetButton({Key key, this.onPressed, this.backGroundColor = Colors.white, this.textColor = Colors.black, @required this.text }) :
        assert (text != null),
        super(key: key);




  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(0.0),
      margin: EdgeInsets.all(0.0),

      child:RaisedButton(

        onPressed: onPressed ,

        textColor: Colors.black,
        elevation: 0.0,
        color: backGroundColor,
        // padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 48.0),
        shape: Border.all(
            width: 0.5,
            color: textColor,
            style: BorderStyle.solid
        ),

        child: Container(
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor,
              fontSize: 14,
            ),
          ),
        ),


      ),
    );
  }
}