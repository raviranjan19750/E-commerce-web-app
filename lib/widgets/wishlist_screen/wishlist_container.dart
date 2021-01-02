import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/wishlist/wishlist_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';

import '../widgets.dart';

class WishlistContainer extends StatelessWidget {
  // WishList Container
  String authID;

  WishlistContainer({Key key, this.authID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    int itemCount = 5;
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
              top: LayoutConstraints.wishlistContainerTop,
              left: LayoutConstraints.wishlistContainerLeft,
              right: LayoutConstraints.wishlistContainerRight,
              bottom: LayoutConstraints.wishlistContainerBottom,
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
                WishlistContainerGrid(
                  itemCount: itemCount,
                  wishlist: state.wishlist,
                  authID: authID,
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

class WishlistContainerGrid extends StatefulWidget {
  const WishlistContainerGrid({
    this.wishlist,
    this.authID,
    Key key,
    @required this.itemCount,
  }) : super(key: key);

  final int itemCount;
  final String authID;
  final List<Wishlist> wishlist;

  @override
  _WishlistContainerGridState createState() => _WishlistContainerGridState();
}

class _WishlistContainerGridState extends State<WishlistContainerGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Grid View to display different Products
      child: Padding(
        padding: const EdgeInsets.only(
          top: LayoutConstraints.wishlistGridTop,
          bottom: 8.0,
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: widget.itemCount,
            childAspectRatio: (MediaQuery.of(context).size.width * 0.08) /
                (MediaQuery.of(context).size.height * 0.2),
          ),
          itemCount: widget.wishlist.length,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return WishlistProductItem(
              product: widget.wishlist[index],
              authID: widget.authID,
            );
          },
        ),
      ),
    );
  }
}
