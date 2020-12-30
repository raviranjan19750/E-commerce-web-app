import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../widgets.dart';

class OrderTitleDeliveryStatus extends StatelessWidget {
  final String statusValue;
  final List<Tracking> tracking;

  const OrderTitleDeliveryStatus({
    Key key,
    this.statusValue,
    this.tracking,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: ('Order will be delivered by \nPlaced On:\nShipped On:'),
      child: Text(statusValue),
      textStyle: TextStyle(
        //fontFeatures: [FontFeature(feature)],

        color: Colors.black,
        fontSize: 14,
      ),
      padding: const EdgeInsets.all(8),
      excludeFromSemantics: true,
      decoration: BoxDecoration(
        boxShadow: [
          //background color of box
          BoxShadow(
            color: Colors.grey,

            blurRadius: 25.0, // soften the shadow
            spreadRadius: 5.0, //extend the shadow
            offset: Offset(
              0, // Move to right 10  horizontally
              0, // Move to bottom 10 Vertically
            ),
          )
        ],
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        border: Border.all(
          color: Colors.orange,
        ),
      ),
    );
  }
}
