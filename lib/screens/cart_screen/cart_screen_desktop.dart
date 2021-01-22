import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/cart/cart_bloc.dart';
import 'package:living_desire/bloc/cart_total/cart_total_bloc.dart';
import 'package:living_desire/screens/emptyState/EmptyStateScreen.dart';
import 'package:living_desire/screens/login/login_view.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class CartScreenDesktop extends StatelessWidget {
  void _showLoginDialog(BuildContext context) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return LoginScreen();
        });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      switch (state.status) {
        case AuthenticationStatus.authenticated:
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                  create: (context) =>
                      CartBloc(cartRepository: RepositoryProvider.of(context))
                        ..add(LoadAllCart(state.user.uid))),
              BlocProvider(
                create: (context) => CartTotalBloc(
                    cartRepository: RepositoryProvider.of(context)),
              ),
            ],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonList(
                  isMyCartSelected: true,
                ),
                Expanded(child: CartContainer()),
              ],
            ),
          );
        case AuthenticationStatus.unauthenticated:
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonList(
                isMyCartSelected: true,
              ),
              Expanded(
                child: EmptyStateScreen(
                    primaryText: Strings.cartLoginText,
                    actionButtonText: Strings.loginText,
                    secondaryText: "",
                    assetPath: 'assets/images/cart_empty_state.png',
                    onPressed: () {
                      _showLoginDialog(context);
                    }),
              ),
            ],
          );

        default:
          return Container();
      }
    });
  }
}
