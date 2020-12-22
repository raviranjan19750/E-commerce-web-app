import 'package:flutter/material.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';

class CartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // Using Responsive widget show mobile and desktop website
        body: Responsive(
          //Mobile Website
          mobile: CartScreenMobile(),
          // Desktop Website
          desktop:
              CartScreenDesktop(),
        ),
      ),
    );
  }
}
