import 'package:flutter/material.dart';

import 'dart:js' as js;

class NavigationService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(String routeName, {Map<String, String> queryParams, bool newTab = false}) {
    if (queryParams != null) {
      routeName = Uri(path: routeName, queryParameters: queryParams).toString();
    }
    print(routeName);
    if (newTab) {
      return js.context.callMethod('open', ["#"+ routeName]);
    } else {
      return navigatorKey.currentState.pushNamed(routeName);
    }
  }

  void goBack() {
    return navigatorKey.currentState.pop();
  }
}
