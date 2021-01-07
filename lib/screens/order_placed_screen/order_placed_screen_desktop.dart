import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/ProviderModels/PlacedOrderProvider.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import 'package:living_desire/screens/login/login_view.dart';
import 'package:provider/provider.dart';
import '../../widgets/widgets.dart';
import '../../models/models.dart';

class OrderPlacedScreenDesktop extends StatelessWidget {
  // Desktop Website Order Placed Screen


  bool init = false;
  String orderKey;
  OrderPlacedScreenDesktop({this.orderKey});

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
          return ChangeNotifierProvider(
              lazy: false,
              create: (context) => PlacedOrderProvider(),
              child: Consumer<PlacedOrderProvider>(
                builder: (BuildContext context, PlacedOrderProvider value, Widget child) {

                  if (!init) {
                    Provider.of<PlacedOrderProvider>(context, listen: false).initOrder("cUnWh3cVAWOLDwBw9zJc");
                    init = true;
                  }

                  if(value.isInitialized)
                    return Row(
                    children: [
                      Expanded(
                        child: OrderPlacedContainer(
                          order: value.order,
                        ),
                      ),
                      OrderPlacedStatusContainer(
                        order: value.order,
                      ),
                    ],
                  );
                  else
                    return Center(child: CircularProgressIndicator(),);

                },
              ));

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
