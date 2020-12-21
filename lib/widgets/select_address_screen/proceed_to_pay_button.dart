import 'package:flutter/material.dart';
import '../../config/configs.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../services/sevices.dart';
import '../../models/models.dart';

class ProceedToPayButton extends StatelessWidget {
  // List of cart Items
  final List<Cart> cart;

  const ProceedToPayButton({
    Key key,
    this.cart,
  }) : super(key: key);
  // Proceed To PAy Button
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Create Payment Order Function
          Future<void> createPaymentOrder() async {
            double amount = 100;
            var data = {'amount': amount, 'authID': 'SampleAuthtest'};

            print('orderData: ' + data.toString());

            HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
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

          // Razor pay integration
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

    // Container(
    //   padding: EdgeInsets.all(8),
    //   decoration: BoxDecoration(
    //     color: Palette.secondaryColor,
    //   ),
    //   // Place Order Button
    //   child: InkWell(
    //     onTap: () {
    //       // call cloud function to return order id
    //       print('Proceed To Pay');

    //       // Create Payment Order Function
    //       Future<void> createPaymentOrder() async {
    //         double amount = 100;
    //         var data = {'amount': amount, 'authID': 'SampleAuthtest'};

    //         print('orderData: ' + data.toString());

    //         HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
    //           'createPaymentOrder',
    //         );
    //         final results = await callable(data).then((value) {
    //           print('Razor Pay Payment' + value.data.toString());
    //           // Catch Error Handling

    //           return showDialog(
    //             context: context,
    //             builder: (BuildContext context) {
    //               return RazorPayWeb(
    //                 orderData: value.data,
    //               );
    //             },
    //           );
    //         });

    //         print('Results: ' + results.data);
    //       }

    //       // Razor pay integration
    //       createPaymentOrder();
    //     },
    //     child: Text(
    //       Strings.proceedToPay,
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 20,
    //       ),
    //     ),
    //   ),
    // );
  }
}
