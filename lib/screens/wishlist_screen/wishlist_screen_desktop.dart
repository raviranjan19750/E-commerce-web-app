import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/screens/emptyState/EmptyStateScreen.dart';
import 'package:living_desire/screens/login/login_view.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class WishlistScreenDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _showLoginDialog(BuildContext context) async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return LoginScreen();
          });
    }

    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      switch (state.status) {
        case AuthenticationStatus.authenticated:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) => WishlistBloc(
                      wishlistRepository: RepositoryProvider.of(context),
                      configBloc: BlocProvider.of(context))
                    ..add(LoadAllWishlist(state.user.uid))),
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
                  child: WishlistContainer(
                    authID: state.user.uid,
                  ),
                ),
              ],
            ),
          );
        case AuthenticationStatus.unauthenticated:
          return EmptyStateScreen(
            primaryText: Strings.wishListLoginText,
            actionButtonText: Strings.loginText,
            secondaryText: "",
            assetPath: 'assets/images/wishlist_empty_state.png',
            onPressed: () {
              _showLoginDialog(context);
            }
          );
        default:
          return Container();
      }
    });
  }
}
