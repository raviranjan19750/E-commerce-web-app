import 'package:flutter/material.dart';
import 'package:living_desire/widgets/sub_app_bar_button.dart';
import '../config/configs.dart';

// Might Need to Change Class name
class SubAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
