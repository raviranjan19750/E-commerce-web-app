import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class SearchResultNotFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(top: 64.0),
          child: Image(
            image: AssetImage('assets/images/search_result_not_match.png'),
            width: MediaQuery.of(context).size.width * 0.40,
            height: MediaQuery.of(context).size.height * 0.40,
          ),
        ),
        SizedBox(
          height: 80,
        ),
        Text(
          Strings.searchPrimaryText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.normal,
              color: Colors.blueGrey),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          Strings.searchSecondaryText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w100,
            color: Colors.grey[400],
          ),
        ),
        SizedBox(
          height: 20,
        ),
      ],
    );
  }
}
