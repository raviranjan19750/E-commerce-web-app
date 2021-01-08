import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/widgets/ProductDetailScreenWidgets/customButtonWidgets.dart';

class EmptyStateScreen extends StatelessWidget {
  final String primaryText;
  final String secondaryText;
  final String actionButtonText;
  final String assetPath;
  final VoidCallback onPressed;

  const EmptyStateScreen(
      {Key key,
      this.primaryText,
      this.secondaryText = "",
      this.actionButtonText,
      this.assetPath = 'assets/images/logo.jpeg',
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Image(
            image: AssetImage(assetPath),
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.40,
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Text(
          primaryText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          secondaryText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w100,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(
          height: 40,
        ),
        Container(
          height: 50,
          child: CustomWidgetButton(
            onPressed: onPressed,
            backGroundColor: Colors.black,
            textColor: Colors.white,
            text: actionButtonText,
          ),
        ),

        SizedBox(height: 50,)
      ],
    );
  }
}
