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
      selectedTabBackgroundColor: Colors.black,
      tabTextStyle: TextStyle(color: Colors.black),
      indicatorColor: Colors.white,
      indicatorSide: IndicatorSide.end,
      indicatorWidth: 20.0,
      contentScrollAxis: Axis.vertical,
      selectedTabTextStyle: TextStyle(
        color: Colors.white,
      ),
      tabsWidth: 200,
      tabs: <Tab>[
        // Wishlist Tab
        Tab(
          text: Strings.myWishlist,

          // child: Container(
          //   child: Row(
          //     children: [
          //       Text(
          //         Strings.myWishlist,
          //       ),
          //       Icon(Icons.arrow_right),
          //     ],
          //   ),
          // ),
        ),
        // My Orders Tab
        Tab(
          text: Strings.myOrders,

          // child: Container(
          //   child: Row(
          //     children: [
          //       Text(Strings.myOrders),
          //       Icon(Icons.arrow_right),
          //     ],
          //   ),
          // ),
        ),
        // Normal Orders Tab

        Tab(
          text: Strings.normalOrders,
          // child: Container(
          //   child: Row(
          //     children: [
          //       Text(Strings.normalOrders),
          //       Icon(Icons.arrow_right),
          //     ],
          //   ),
          // ),
        ),
        // Custom Orders Tab
        Tab(
          text: Strings.customOrders,
          // child: Container(
          //   child: Row(
          //     children: [
          //       Text(Strings.customOrders),
          //       Icon(Icons.arrow_right),
          //     ],
          //   ),
          // ),
        ),
        // My Cart Tab
        Tab(
          text: Strings.myCart,
          // child: Container(
          //   child: Row(
          //     children: [
          //       Text(Strings.myCart),
          //       Icon(Icons.arrow_right),
          //     ],
          //   ),
          //),
        ),
        // Manage Addresss Tab
        Tab(
          text: Strings.manageAddresses,
          // child: Container(
          //   child: Row(
          //     children: [
          //       Text(Strings.manageAddresses),
          //       Icon(Icons.arrow_right),
          //     ],
          //   ),
          // ),
        ),
      ],
      contents: [
        // Widgets of different options
        WishlistContainer(),
        // WishlistContainer(),
        // WishlistContainer(),
        // WishlistContainer(),
        // WishlistContainer(),
        // WishlistContainer(),
        NormalOrdersContainer(),
        NormalOrdersContainer(),
        CustomOrdersContainer(),
        CartContainer(),
        ManageAddressesContainer(),
      ],
    );
  }
}
