import 'package:flutter/material.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';

class OrderScreenDesktop extends StatefulWidget {
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
        padding: const EdgeInsets.all(24.0),
        child: Container(
          // Order Navigation screen between differnt widgets
          child: OrderNavScreen(
            scrollController: widget.scrollController,
          ),
        ),
      ),
    );
  }
}
