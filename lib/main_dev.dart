import 'package:flutter/material.dart';
import './config/configs.dart';
import './main.dart';

void main() {
  // Development Flavor Build
  var configuredApp = AppConfig(
    appTitle: Strings.websiteName,
    buildFlavor: "Development",
    // MyApp widget from main.dart
    child: MyApp(),
  );
  return runApp(configuredApp);
}
