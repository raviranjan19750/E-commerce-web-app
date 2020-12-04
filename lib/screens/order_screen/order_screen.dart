import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';

class OrderScreen extends StatefulWidget {
  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // TrackingScrollController added for tracking scroll cursor
  final TrackingScrollController trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    // Always dispose a controller when used
    trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        // Using Responsive widget show mobile and desktop website
        body: Responsive(
          //Mobile Website
          mobile: OrderScreenMobile(scrollController: trackingScrollController),
          // Desktop Website
          desktop:
              OrderScreenDesktop(scrollController: trackingScrollController),
        ),
      ),
    );
  }
}
