import 'package:clippy_flutter/clippy_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/cart/cart_bloc.dart';
import 'package:living_desire/bloc/cart_total/cart_total_bloc.dart';
import 'package:living_desire/screens/emptyState/EmptyStateScreen.dart';
import 'package:living_desire/service/navigation_service.dart';
import '../../config/configs.dart';
import '../../main.dart';
import '../../routes.dart';
import '../widgets.dart';

class CartListContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Cart Bloc : list of carts
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      if (state is CartDetailLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
      // Carts acquired in state
      if (state is CartDetailLoadingSuccessful) {
        // Bloc Provider to cart total bloc
        // No. of items in cart
        if(state.cart.length == 0) {
          return EmptyStateScreen(
            primaryText: Strings.cartPrimaryText,
            secondaryText: "",
            actionButtonText: Strings.continueShopping,
            assetPath: 'assets/images/cart_empty_state.png',
            onPressed: () {
              locator<NavigationService>().navigateTo(RoutesConfiguration.SEARCH_ALL_PRODUCT, queryParams: {"search": ""});
            },
          );
        }
        BlocProvider.of<CartTotalBloc>(context).add(UpdateCartTotal());
        return Padding(
          padding: const EdgeInsets.only(
            top: 16.0,
            right: 16.0,
            left: 16.0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),

                child: Text(
                  Strings.deliveringTo,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 14,
                  ),
                ),
                //TODO: Get Pincode
              ),

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
                    // Bloc Builder to state of carts quantity

                    child: BlocBuilder<CartTotalBloc, CartTotalState>(
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            right: 10.0,
                          ),
                          child: state.totalQuantity > 1
                              ? Text(
                                  state.totalQuantity.toString() +
                                      ' ' +
                                      Strings.items,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  state.totalQuantity.toString() +
                                      ' ' +
                                      Strings.item,
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              // Cart Items
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.cart.length,
                  itemBuilder: (context, index) {
                    return CartItemView(
                      cart: state.cart[index],
                    );
                  }),

              // Subtotal Container
              Container(
                child: BlocBuilder<CartTotalBloc, CartTotalState>(
                  builder: (context, state) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          Strings.subTotal +
                              ' (${state.totalQuantity} Items): ',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          Strings.rupeesSymbol + ' ${state.retailTotal}',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      }

      return Container(
        child: Icon(Icons.warning),
      );
    });
  }
}
