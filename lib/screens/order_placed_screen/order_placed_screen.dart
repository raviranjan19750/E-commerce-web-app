import 'package:flutter/material.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';
import '../../data/data.dart';

class OrderPlacedScreen extends StatefulWidget {
  @override
  _OrderPlacedScreenState createState() => _OrderPlacedScreenState();
}

class _OrderPlacedScreenState extends State<OrderPlacedScreen> {
  // TrackingScrollController added for tracking scroll cursor
  final TrackingScrollController trackingScrollController =
      TrackingScrollController();
  //TODO: Later Get Order From Cart Place Order
  final Order orders = order[0];

  //_OrderPlacedScreenState(this.order,);

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
          mobile: OrderPlacedScreenMobile(
              scrollController: trackingScrollController),
          // Desktop Website
          desktop: OrderPlacedScreenDesktop(
            scrollController: trackingScrollController,
            order: orders,
          ),
        ),
      ),
    );
  }
}
