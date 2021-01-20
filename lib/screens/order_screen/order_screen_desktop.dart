import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/normal_order/normal_order_bloc.dart';
import 'package:living_desire/screens/emptyState/EmptyStateScreen.dart';
import 'package:living_desire/screens/login/login_view.dart';
import '../screens.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class OrderScreenDesktop extends StatelessWidget {
  // Desktop Website Order Screen

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
                  create: (context) => NormalOrderBloc(
                      normalOrderRepository: RepositoryProvider.of(context))
                    ..add(LoadAllNormalOrders(state.user.uid))),
            ],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonList(
                  isMyOrderSelected: true,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: NormalOrdersContainer(),
                ),
              ],
            ),
          );
        case AuthenticationStatus.unauthenticated:
          return EmptyStateScreen(
              primaryText: Strings.orderLoginText,
              actionButtonText: Strings.loginText,
              secondaryText: "",
              assetPath: 'assets/images/order_empty_state.png',
              onPressed: () {
                _showLoginDialog(context);
              });
        default:
          return Container();
      }
    });
  }
}
