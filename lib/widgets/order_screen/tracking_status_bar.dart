import 'package:flutter/material.dart';
import 'package:living_desire/config/strings.dart';

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
      child: Stepper(
        steps: steps,
        type: StepperType.horizontal,

      ),
    );
  }
}
