import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/screens/emptyState/EmptyStateScreen.dart';
import 'package:living_desire/screens/login/login_view.dart';
import 'package:living_desire/screens/manage_addresses_screen/my_profile_screen.dart';
import 'package:living_desire/screens/manage_addresses_screen/my_wallet.dart';
import '../../widgets/widgets.dart';
import '../../config/configs.dart';

class ManageAddressesScreenDesktop extends StatelessWidget {
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
                  create: (context) => ManageAddressesBloc(
                      addresssRepository: RepositoryProvider.of(context))
                    ..add(LoadAllAddresses(state.user.uid))),
            ],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ButtonList(
                  isManageAddressesSelected: true,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyProfileScreen(),
                        MyWallet(),
                      ],
                    ),
                    ManageAddressesContainer(
                      authID: state.user.uid,
                    ),
                  ],
                )),
              ],
            ),
          );
        case AuthenticationStatus.unauthenticated:
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ButtonList(
                isManageAddressesSelected: true,
              ),
              Expanded(
                child: EmptyStateScreen(
                    primaryText: Strings.cartLoginText,
                    actionButtonText: Strings.loginText,
                    secondaryText: "",
                    assetPath: 'assets/images/myaccount_emptystate.png',
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
