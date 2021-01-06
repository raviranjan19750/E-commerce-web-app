import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/screens/login/login_view.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class OrderPlacedScreenDesktop extends StatelessWidget {
  // Desktop Website Order Placed Screen

  final Order order = orders[0];

  // const OrderPlacedScreenDesktop({
  //   Key key,
  //   this.order,
  // }) : super(key: key);

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
          return Row(
            children: [
              Expanded(
                child: OrderPlacedContainer(
                  order: order,
                ),
              ),
              OrderPlacedStatusContainer(
                order: order,
              ),
            ],
          );
        case AuthenticationStatus.unauthenticated:
          return Center(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
                borderRadius: BorderRadius.circular(4),
              ),
              // Login Button
              child: InkWell(
                onTap: () {
                  _showLoginDialog(context);
                },
                child: Text(
                  Strings.loginText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        default:
          return Container();
      }
    });
  }
}
