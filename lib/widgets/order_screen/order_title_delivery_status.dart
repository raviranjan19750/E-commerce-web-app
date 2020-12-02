import 'package:flutter/material.dart';
import '../../models/models.dart';

class OrderTitleDeliveryStatus extends StatelessWidget {
  final double status;
  final List<Tracking> tracking;

  const OrderTitleDeliveryStatus({
    Key key,
    this.status,
    this.tracking,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
