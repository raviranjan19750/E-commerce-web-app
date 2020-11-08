import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class AppConfig extends InheritedWidget {
  // Config File for differnt Builds development and Production
  final String appTitle;
  final String buildFlavor;
  final Widget child;

  AppConfig(
      {@required this.child,
      @required this.appTitle,
      @required this.buildFlavor});

  //Extending Inherited Widget for differnt Builds
  static AppConfig of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
