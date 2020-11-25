import 'package:flutter/material.dart';
import 'package:living_desire/widgets/app_bar/sub_app_bar_button.dart';
import '../../config/configs.dart';

// Might Need to Change Class name
class SubAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: Container(),
        ),

        Container(
          padding: EdgeInsets.only(left: 24,bottom: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(120)),
            boxShadow:  [
              BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2.0,
                  offset: Offset(-2, 4)
              ),
            ],
          ),

          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Why us? Button
              SubAppBarButton(
                buttonName: Strings.whyUs,
                onPressed: () {},
              ),
              const SizedBox(
                width: 15.0,
              ),
              // For Offices Button
              SubAppBarButton(
                buttonName: Strings.forOffices,
                onPressed: () {},
              ),
              const SizedBox(
                width: 15.0,
              ),
              // For Property Button
              SubAppBarButton(
                buttonName: Strings.forProperty,
                onPressed: () {},
              ),
              const SizedBox(
                width: 15.0,
              ),
              // For Home Button
              SubAppBarButton(
                buttonName: Strings.forHome,
                onPressed: () {},
              ),
              const SizedBox(
                width: 10.0,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
