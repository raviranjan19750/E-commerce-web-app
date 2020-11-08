import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  // Responsive Widget for mobile and website
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  const Responsive({
    Key key,
    @required this.mobile,
    this.tablet,
    @required this.desktop,
  }) : super(key: key);
  // Verifies the device specs: Mobile or Desktop
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 800;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 800 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  @override
  Widget build(BuildContext context) {
    // Build Layout for desktop, tablet and Mobile
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1200) {
          return desktop;
        } else if (constraints.maxWidth >= 800) {
          // TODO: Tablet View not configured yet
          return tablet ?? mobile;
        } else {
          return mobile;
        }
      },
    );
  }
}
