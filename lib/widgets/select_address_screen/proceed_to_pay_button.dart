import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import '../../config/configs.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../services/sevices.dart';
import '../../models/models.dart';

class ProceedToPayButton extends StatelessWidget {
  // List of cart Items
  final List<Cart> cart;
  final Address selectedAddress;

  const ProceedToPayButton({
    Key key,
    this.cart,
    this.selectedAddress,
  }) : super(key: key);
  // Proceed To PAy Button
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SelectAddressBloc, SelectAddressState>(
        builder: (context, state) {
      if (state is SelectAddressDetailLoading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is SelectAddressDetailLoadingSuccessful) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              print(state.address.name);
              //print(selectedAddress.name);
              // Create Payment Order Function
              Future<void> createPaymentOrder() async {
                double amount = 100;
                var data = {'amount': amount, 'authID': 'SampleAuthtest'};

                print('orderData: ' + data.toString());

                HttpsCallable callable =
                    FirebaseFunctions.instance.httpsCallable(
                  'createPaymentOrder',
                );
                final results = await callable(data).then((value) {
                  print('Razor Pay Payment' + value.data.toString());
                  // Catch Error Handling

                  return showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return RazorPayWeb(
                        orderData: value.data,
                      );
                    },
                  );
                });

                print('Results: ' + results.data);
              }

              //Razor pay integration
              createPaymentOrder();
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
                  Strings.proceedToPay,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        );
      }
      return Container();
    });
  }
}
