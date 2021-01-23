import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/analytics/analytics_bloc.dart';
import '../../config/configs.dart';

class AppBarWebName extends StatelessWidget {
  @override
  // AppBar WebSite Name
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        BlocProvider.of<AnalyticsBloc>(context).add(TestAllAnalyticsEvent());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Text(
          Strings.websiteName,
          style: const TextStyle(
            color: Palette.secondaryColor,
            fontSize: 20,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
