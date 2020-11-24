import 'package:flutter/material.dart';

class SubAppBarButton extends StatelessWidget {
  // Buttons widget for Why Us?, For Home...
  final String buttonName;
  final Function onPressed;

  const SubAppBarButton({
    Key key,
    @required this.buttonName,
    @required this.onPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Button for different fields
    return FlatButton(
      onPressed: onPressed,
      child: Text(buttonName),
    );
  }
}
