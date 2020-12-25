import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/wishlist/wishlist_bloc.dart';
import 'package:living_desire/config/configs.dart';

import '../widgets.dart';

class WishlistContainer extends StatelessWidget {
  // WishList Container

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    int itemCount = 4;
    if (width < 1000) {
      itemCount = 2;
    } else if (width < 1200) {
      itemCount = 3;
    }
    return BlocBuilder<WishlistBloc, WishlistState>(
      builder: (context, state) {
        if (state is WishlistDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is WishlistDetailLoadingSuccessful) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 16.0,
              right: 50.0,
              bottom: 16.0,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Divider(
                  thickness: 0.5,
                  color: Colors.black54,
                ),
                Diagonal(
                  axis: Axis.vertical,
                  position: DiagonalPosition.TOP_RIGHT,
                  clipHeight: MediaQuery.of(context).size.height * 0.03,
                  child: Container(
                    color: Colors.red[900],
                    width: MediaQuery.of(context).size.width * 0.065,
                    height: MediaQuery.of(context).size.height * 0.03,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          right: 10.0,
                        ),
                        child: state.wishlist.length > 1
                            ? Text(
                                state.wishlist.length.toString() +
                                    ' ' +
                                    Strings.items,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              )
                            : Text(
                                state.wishlist.length.toString() +
                                    ' ' +
                                    Strings.item,
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                Container(
                  // Grid View to display different Products
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: itemCount,
                        childAspectRatio:
                            (MediaQuery.of(context).size.width * 0.12) /
                                (MediaQuery.of(context).size.height * 0.32),
                      ),
                      itemCount: state.wishlist.length,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return WishlistProductItem(
                          product: state.wishlist[index],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
