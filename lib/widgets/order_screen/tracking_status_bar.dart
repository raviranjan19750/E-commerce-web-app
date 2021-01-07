import 'package:flutter/material.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/OrderTimeline.dart';

class TrackingStatusBar extends StatelessWidget {
  // Tacking Status Bar
  @override
  Widget build(BuildContext context) {
    final List<Step> steps = [
      Step(
        title: Text(
          Strings.ordered,
        ),
        isActive: true,
        content: Text('Date'),
      ),
      Step(
        isActive: true,
        title: Text(
          Strings.shipped,
        ),
        content: Text('Date'),
      ),
      Step(
        title: Text(
          Strings.delivered,
        ),
        isActive: true,
        content: Text('Date'),
      ),
    ];
    return Container(
      width: 400,
      height: 100,
      margin: EdgeInsets.only(bottom: 16,top: 8),
      child: OrderTimeline(),
    );
  }
}
