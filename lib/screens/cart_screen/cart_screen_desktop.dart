import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class CartScreenDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  const CartScreenDesktop({
    Key key,
    this.scrollController,
  }) : super(key: key);

  @override
  _CartScreenDesktopState createState() => _CartScreenDesktopState();
}

class _CartScreenDesktopState extends State<CartScreenDesktop> {
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
                isMyCartSelected: true,
              ),
              Expanded(child: CartContainer()),
            ],
          ),
        ),
      ),
    );
  }
}
