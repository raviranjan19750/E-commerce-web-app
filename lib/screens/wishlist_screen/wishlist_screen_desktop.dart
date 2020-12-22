import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class WishlistScreenDesktop extends StatefulWidget {
  final TrackingScrollController scrollController;

  const WishlistScreenDesktop({
    Key key,
    this.scrollController,
  }) : super(key: key);
  @override
  _WishlistScreenDesktopState createState() => _WishlistScreenDesktopState();
}

class _WishlistScreenDesktopState extends State<WishlistScreenDesktop> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                WishlistBloc(wishlistRepository: RepositoryProvider.of(context))
                  ..add(LoadAllWishlist('id1'))),
        BlocProvider(
            create: (context) =>
                CartBloc(cartRepository: RepositoryProvider.of(context))),
      ],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ButtonList(
            isWishlistSelected: true,
          ),
          Expanded(
            child: WishlistContainer(),
          ),
        ],
      ),
    );
  }
}
