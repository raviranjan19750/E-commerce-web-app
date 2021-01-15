import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButtonWidget(
      {Key key,
        @required this.text,
        this.backgroundColor = Colors.white,
        this.textColor = Colors.black,
        this.onPressed})
      : assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: onPressed,
        textColor: Colors.black,
        elevation: 0.0,
        color: backgroundColor,
        shape:
        Border.all(width: 0.5, color: textColor, style: BorderStyle.solid),
        child: Container(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: textColor, fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
