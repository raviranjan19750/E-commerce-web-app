import 'package:flutter/material.dart';
import 'package:living_desire/service/navigation_service.dart';

import '../../main.dart';
import '../../routes.dart';

class AppBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          locator<NavigationService>()
              .navigateTo(RoutesConfiguration.HOME_PAGE);
        },
        child: Image(
          image: AssetImage('assets/images/logo.jpeg'),
          width: 48,
          height: 48,
        ),
      ),
    );
  }
}
