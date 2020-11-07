import 'package:flutter/material.dart';
import './config/configs.dart';
import 'main.dart';

void main() {
  // Production Flavor
  var configuredApp = AppConfig(
    appTitle: "Flutter Flavors",
    buildFlavor: "Production",
    child: MyApp(),
  );
  return runApp(configuredApp);
}
