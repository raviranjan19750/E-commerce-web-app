import '../config/configs.dart';
import '../widgets/widgets.dart';
import './screens.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TrackingScrollController trackingScrollController =
      TrackingScrollController();

  @override
  void dispose() {
    trackingScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Responsive(
          mobile: HomeScreenMobile(scrollController: trackingScrollController),
          desktop:
              HomeScreenDesktop(scrollController: trackingScrollController),
        ),
      ),
    );
  }
}
