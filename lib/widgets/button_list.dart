import 'dart:core';
import 'package:flutter/material.dart';
import 'package:living_desire/routes.dart';
import '../config/configs.dart';

class ButtonList extends StatelessWidget {
  final bool isWishlistSelected;
  final bool isMyOrderSelected;
  final bool isMyCartSelected;
  final bool isManageAddressesSelected;

  const ButtonList({
    Key key,
    this.isWishlistSelected = false,
    this.isMyOrderSelected = false,
    this.isMyCartSelected = false,
    this.isManageAddressesSelected = false,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Whishlist List Button
          Container(
            width: MediaQuery.of(context).size.width * 0.18,
            height: 60,
            color: isWishlistSelected ? Colors.black : Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesConfiguration.WISHLIST);
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
                        color: isWishlistSelected ? Colors.white : Colors.black,
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
            color: isMyOrderSelected ? Colors.black : Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesConfiguration.MY_ORDERS);
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
                        color: isMyOrderSelected ? Colors.white : Colors.black,
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
            color: isMyCartSelected ? Colors.black : Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, RoutesConfiguration.CART);
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
                        color: isMyCartSelected ? Colors.white : Colors.black,
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
            color:
                isManageAddressesSelected ? Colors.black : Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                    context, RoutesConfiguration.MANAGE_ADDRESSES);
              },
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      Strings.manageAddresses,
                      style: TextStyle(
                        color: isManageAddressesSelected
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
    );
  }
}
