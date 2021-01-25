import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/normal_order/normal_order_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/screens/emptyState/EmptyStateScreen.dart';
import 'package:living_desire/service/navigation_service.dart';
import '../../main.dart';
import '../../routes.dart';
import '../widgets.dart';

class NormalOrdersContainer extends StatelessWidget {
  // Normal Order Container
  @override
  Widget build(BuildContext context) {
    // Order Bloc: list of orders
    return BlocBuilder<NormalOrderBloc, NormalOrderState>(
      builder: (context, state) {
        if (state is NormalOrderDetailLoading) {
          return Center(child: CircularProgressIndicator());
        }
        // Orders acquired in state
        else if (state is NormalOrderDetailLoadingSuccessful) {
          if (state.order.length == 0) {
            return EmptyStateScreen(
              primaryText: Strings.orderPrimaryText,
              secondaryText: Strings.orderSecondaryText,
              actionButtonText: Strings.continueShopping,
              assetPath: 'assets/images/order_empty_state.png',
              onPressed: () {
                locator<NavigationService>().navigateTo(
                  RoutesConfiguration.HOME_PAGE,
                );
              },
            );
          }

          return Padding(
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Container(
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
                          child: state.order.length > 1
                              ? Text(
                                  state.order.length.toString() +
                                      ' ' +
                                      Strings.items,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  state.order.length.toString() +
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
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.order.length,
                      itemBuilder: (context, index) {
                        return OrderItem(
                          order: state.order[index],
                        );
                      }),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
