import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';

class SelectAddressScreenDesktop extends StatelessWidget {
  final TrackingScrollController scrollController;

  const SelectAddressScreenDesktop({Key key, this.scrollController})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        child: Row(
          children: [
            SelectAddressContainer(),
            CartTotal(),
          ],
        ),
      ),
    );
  }
}
