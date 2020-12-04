import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class SelectAddressScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;
  final List<Cart> cart;

  const SelectAddressScreenDesktop({
    Key key,
    this.scrollController,
    this.cart,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: Row(
          children: [
            SelectAddressContainer(),
            SelectAddressCartTotal(
              cart: cart,
            ),
          ],
        ),
      ),
    );
  }
}
