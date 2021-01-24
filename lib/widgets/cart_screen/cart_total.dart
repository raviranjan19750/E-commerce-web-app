import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:living_desire/bloc/cart_total/cart_total_bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/screens/login/login_view.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:provider/provider.dart';

import '../../logger.dart';

class CartTotalView extends StatelessWidget {
  var LOG = LogBuilder.getLogger();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartTotalBloc, CartTotalState>(
        builder: (context, state) {
      LOG.i(state);
      return CartTotal(
        cart: state,
      );
    });
  }
}

class CartTotal extends StatelessWidget {
  final CartTotalState cart;

  CartTotal({
    Key key,
    this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 100% Purchase Protection Container
            // Padding(
            //   padding: const EdgeInsets.only(
            //     bottom: 16.0,
            //   ),
            //   child: Card(
            //     elevation: 3.0,
            //     child: Container(
            //       color: Colors.grey[200],
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             CircleAvatar(
            //               backgroundColor: Colors.grey,
            //             ),
            //             Container(
            //               color: Colors.grey[20],
            //               child: Column(
            //                 children: [
            //                   Text(
            //                     Strings.purchaseProtection,
            //                     softWrap: true,
            //                     style: TextStyle(
            //                       fontSize: 16,
            //                     ),
            //                   ),
            //                   Text(
            //                     '${Strings.orignalProducts} | ${Strings.securePayments}',
            //                     softWrap: true,
            //                     style: TextStyle(
            //                       fontSize: 10,
            //                       color: Colors.green,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.subTotal + ' ( ${cart.totalQuantity} Items):',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '\u{20B9} ${cart.retailTotal}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 10.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Strings.deliveryCharges),
                  Text('Delivery Charges'),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Strings.discount),
                  Text('data'),
                  //Text('-${cart.retailTotal - cart.discountTotal}'),
                ],
              ),
            ),

            Divider(
              color: Colors.black,
              thickness: 0.3,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Strings.total,
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    '\u{20B9} ${cart.discountTotal}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: 20,
            ),
            MultiProvider(
              providers: [
                BlocProvider(create: (context) => SelectAddressBloc()),
              ],
              child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                  builder: (context, state) {
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // BlocProvider.of<SelectAddressBloc>(context)
                          //     .add(LoadNormalCartDetails(
                          //   authID: state.user.uid,
                          //   totalItems: cart.totalQuantity,
                          // ));
                          locator<NavigationService>().navigateTo(
                              RoutesConfiguration.SELECT_ADDRESS,
                              queryParams: {
                                "isNormalCart": "true",
                              });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.22,

                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Palette.secondaryColor,
                          ),
                          // Place Order Button

                          child: Center(
                            child: Text(
                              Strings.placeOrder,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  case AuthenticationStatus.unauthenticated:
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          // BlocProvider.of<SelectAddressBloc>(context)
                          //     .add(LoadNormalCartDetails(
                          //   authID: state.user.uid,
                          //   totalItems: cart.totalQuantity,
                          // ));
                          // locator<NavigationService>().navigateTo(
                          //     RoutesConfiguration.SELECT_ADDRESS,
                          //     queryParams: {
                          //       "isNormalCart": "true",
                          //     });

                          void _showLoginDialog(BuildContext context) async {
                            await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LoginScreen();
                                });
                          }

                          _showLoginDialog(context);
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.22,

                          padding: EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Palette.secondaryColor,
                          ),
                          // Place Order Button

                          child: Center(
                            child: Text(
                              Strings.loginToContinue,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  default:
                    return Container();
                }
              }),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Strings.selectAddressNextStep,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    Strings.needHelp,
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
