import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/filter/filter_bloc.dart';

import '../../config/configs.dart';
import '../../widgets/widgets.dart';
import '../screens.dart';
import 'package:flutter/material.dart';

// Extends Stateful widget for mobile and desktop app

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      child: HomeScreenDesktop(scrollController: trackingScrollController),
    );
  }
}
