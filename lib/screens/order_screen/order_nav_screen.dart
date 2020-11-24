import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import '../../config/configs.dart';
import '../../widgets/widgets.dart';

class OrderNavScreen extends StatefulWidget {
  final TrackingScrollController scrollController;

  const OrderNavScreen({Key key, this.scrollController}) : super(key: key);

  @override
  _OrderNavScreenState createState() => _OrderNavScreenState();
}

class _OrderNavScreenState extends State<OrderNavScreen> {
  @override
  Widget build(BuildContext context) {
    return VerticalTabs(
      tabsWidth: 200,
      tabs: <Tab>[
        Tab(
          child: Container(
            child: Row(
              children: [
                Text(Strings.myWishlist),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Row(
              children: [
                Text(Strings.myOrders),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Row(
              children: [
                Text(Strings.normalOrders),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Row(
              children: [
                Text(Strings.customOrders),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Row(
              children: [
                Text(Strings.myCart),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
        Tab(
          child: Container(
            child: Row(
              children: [
                Text(Strings.manageAddresses),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ],
      contents: [
        WishlistContainer(),
        NormalOrdersContainer(),
        NormalOrdersContainer(),
        CustomOrdersContainer(),
        CartContainer(),
        ManageAddressesContainer(),
      ],
    );
  }
}
