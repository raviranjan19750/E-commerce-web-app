import 'package:flutter/material.dart';
import './config/configs.dart';
import 'main.dart';

void main() {
  // Development Flavor Build
  var configuredApp = AppConfig(
    appTitle: "Flutter Flavors Dev",
    buildFlavor: "Development",
    child: MyApp(),
  );
  return runApp(configuredApp);
}
