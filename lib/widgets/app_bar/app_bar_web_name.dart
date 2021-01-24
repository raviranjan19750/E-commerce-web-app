import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/analytics/analytics_bloc.dart';
import 'package:living_desire/service/navigation_service.dart';
import '../../config/configs.dart';
import '../../main.dart';
import '../../routes.dart';

class AppBarWebName extends StatelessWidget {
  @override
  // AppBar WebSite Name
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<AnalyticsBloc>(context).add(TestAllAnalyticsEvent());
        locator<NavigationService>().navigateTo(RoutesConfiguration.HOME_PAGE);
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
