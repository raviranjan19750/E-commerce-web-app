import 'package:flutter/material.dart';
import '../../models/models.dart';

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
    return Container(
      child: Text(statusValue.toString()),
    );
  }
}
