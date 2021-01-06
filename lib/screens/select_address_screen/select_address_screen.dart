import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class SelectAddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // Using Responsive widget show mobile and desktop website
        body: Responsive(
          //Mobile Website
          mobile: SelectAddressScreenMobile(),
          // Desktop Website
          desktop: SelectAddressScreenDesktop(),
        ),
      ),
    );
  }
}
