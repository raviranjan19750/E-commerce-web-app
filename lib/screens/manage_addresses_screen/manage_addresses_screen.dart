import 'package:flutter/material.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';

class ManageAddressesScreen extends StatefulWidget {
  @override
  _ManageAddressesScreenState createState() => _ManageAddressesScreenState();
}

class _ManageAddressesScreenState extends State<ManageAddressesScreen> {
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
          mobile: ManageAddressesScreenMobile(
              scrollController: trackingScrollController),
          // Desktop Website
          desktop: ManageAddressesScreenDesktop(
              scrollController: trackingScrollController),
        ),
      ),
    );
  }
}
