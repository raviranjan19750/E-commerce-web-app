import 'package:flutter/material.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class OrderScreenDesktop extends StatefulWidget {
  // Desktop Website Order Screen
  final TrackingScrollController scrollController;

  const OrderScreenDesktop({
    Key key,
    this.scrollController,
  }) : super(key: key);

  @override
  _OrderScreenDesktopState createState() => _OrderScreenDesktopState();
}

class _OrderScreenDesktopState extends State<OrderScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonList(
                isMyOrderSelected: true,
              ),
              Expanded(child: NormalOrdersContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
