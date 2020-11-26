import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class OrderPlacedScreenDesktop extends StatelessWidget {
  // Mobile Website Order Placed Screen
  final TrackingScrollController scrollController;
  final Order order;

  const OrderPlacedScreenDesktop({
    Key key,
    @required this.scrollController,
    this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: Build OrderPlacedScreen for desktop
    return Scaffold(
      appBar: CustomAppBar(),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        controller: scrollController,
        child: Container(
          child: Row(
            children: [
              OrderPlacedContainer(
                order: order,
              ),
              OrderPlacedStatusContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
