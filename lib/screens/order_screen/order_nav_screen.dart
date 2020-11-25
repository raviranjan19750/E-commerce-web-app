import 'package:flutter/material.dart';
import 'package:vertical_tabs/vertical_tabs.dart';
import '../../config/configs.dart';
import '../../widgets/widgets.dart';

class OrderNavScreen extends StatefulWidget {
  // Navigate between different option e.g. Cart, wishlist, manage addresses
  final TrackingScrollController scrollController;

  const OrderNavScreen({Key key, this.scrollController}) : super(key: key);

  @override
  _OrderNavScreenState createState() => _OrderNavScreenState();
}

class _OrderNavScreenState extends State<OrderNavScreen> {
  @override
  Widget build(BuildContext context) {
    // Vertical tab bar for different widgets
    return VerticalTabs(
      disabledChangePageFromContentView: true,
      tabsWidth: 200,
      tabs: <Tab>[
        // Wishlist Tab
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
        // My Orders Tab

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
        // Normal Orders Tab

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
        // Custom Orders Tab
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
        // My Cart Tab
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
        // Manage Addresss Tab
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
        // Widgets of different options
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
