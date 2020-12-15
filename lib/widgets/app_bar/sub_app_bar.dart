import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/widgets/app_bar/sub_app_bar_button.dart';
import '../../config/configs.dart';

// Might Need to Change Class name
class SubAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Diagonal(
          axis: Axis.vertical,
          position: DiagonalPosition.TOP_LEFT,
          clipHeight: MediaQuery.of(context).size.height * 0.04,
          child: Card(
            elevation: 5.0,
            shadowColor: Colors.black54,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                bottom: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
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
          ),
        ),
      ],
    );
  }
}
