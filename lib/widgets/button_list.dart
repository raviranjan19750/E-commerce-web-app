import 'dart:core';
import 'package:flutter/material.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/service/navigation_service.dart';
import '../config/configs.dart';

class ButtonList extends StatefulWidget {
  final bool isWishlistSelected;
  final bool isMyOrderSelected;
  final bool isMyCartSelected;
  final bool isManageAddressesSelected;
  bool wishlistAlreadySlected = false;

  bool cartAlreadySlected = false;

  bool normalOrderlistAlreadySlected = false;

  bool myAccountAlreadySlected = false;

  ButtonList({
    Key key,
    this.isWishlistSelected = false,
    this.isMyOrderSelected = false,
    this.isMyCartSelected = false,
    this.isManageAddressesSelected = false,
  }) : super(key: key);

  @override
  _ButtonListState createState() => _ButtonListState();
}

class _ButtonListState extends State<ButtonList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Whishlist List Button
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                height: 60,
                color: widget.isWishlistSelected
                    ? Colors.black
                    : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                        .navigateTo(RoutesConfiguration.WISHLIST);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Strings.myWishlist,
                          style: TextStyle(
                            color: widget.isWishlistSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // My Orders Button
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                height: 60,
                color: widget.isMyOrderSelected
                    ? Colors.black
                    : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                        .navigateTo(RoutesConfiguration.MY_ORDERS);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Strings.myOrders,
                          style: TextStyle(
                            color: widget.isMyOrderSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // My Cart Button
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                height: 60,
                color:
                    widget.isMyCartSelected ? Colors.black : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                        .navigateTo(RoutesConfiguration.CART);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Strings.myCart,
                          style: TextStyle(
                            color: widget.isMyCartSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // Manage Addresses Button
              Container(
                width: MediaQuery.of(context).size.width * 0.18,
                height: 60,
                color: widget.isManageAddressesSelected
                    ? Colors.black
                    : Colors.transparent,
                child: InkWell(
                  onTap: () {
                    locator<NavigationService>()
                        .navigateTo(RoutesConfiguration.MANAGE_ADDRESSES);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'My Account',
                          style: TextStyle(
                            color: widget.isManageAddressesSelected
                                ? Colors.white
                                : Colors.black,
                            fontSize: 16,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right,
                          color: Colors.white,
                          size: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // Expanded(child: Container()),
      ],
    );
  }
}
