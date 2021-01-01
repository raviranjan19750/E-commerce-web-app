import 'dart:html';
import 'package:flutter/material.dart';
import '../../config/configs.dart';
import '../../models/models.dart';
import '../widgets.dart';

class SelectAddressCartTotal extends StatelessWidget {
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
            Padding(
              padding: const EdgeInsets.only(
                bottom: 16.0,
              ),
              child: Card(
                elevation: 3.0,
                child: Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        Container(
                          color: Colors.grey[20],
                          child: Column(
                            children: [
                              Text(
                                Strings.purchaseProtection,
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                '${Strings.orignalProducts} | ${Strings.securePayments}',
                                softWrap: true,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

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
                    Strings.subTotal + ' ( Items):',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    '',
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
                  Text('Discount'),
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
                    'Total',
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

            ProceedToPayButton(
                //cart: cart,
                //selectedAddress: selectedAddress,
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

    // Container(
    //   child: Padding(
    //     padding: const EdgeInsets.all(16.0),
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // 100% Purchase Protection Container
    //         Container(
    //           child: Row(
    //             children: [
    //               CircleAvatar(
    //                 backgroundColor: Colors.grey,
    //               ),
    //               Container(
    //                 color: Colors.grey[20],
    //                 child: Column(
    //                   children: [
    //                     Text(
    //                       Strings.purchaseProtection,
    //                       softWrap: true,
    //                       style: TextStyle(
    //                         fontSize: 16,
    //                       ),
    //                     ),
    //                     Text(
    //                       '${Strings.orignalProducts} | ${Strings.securePayments}',
    //                       softWrap: true,
    //                       style: TextStyle(
    //                         fontSize: 10,
    //                         color: Colors.green,
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),
    //         Container(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Text(Strings.subTotal + ' (total no. of products)'),
    //               Text('Subatotal Amount'),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         Container(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Text(Strings.deliveryCharges),
    //               Text('Delivery Charges'),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 10,
    //         ),
    //         Container(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Text(Strings.discount),
    //               Text('Discount'),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 15,
    //         ),
    //         Divider(
    //           color: Colors.black,
    //           thickness: 0.3,
    //         ),
    //         Container(
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Text(Strings.total),
    //               Text('Total'),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           height: 20,
    //         ),

    //         // Proceed To Pay Button
    //         ProceedToPayButton(
    //           cart: cart,
    //         ),

    //         SizedBox(
    //           height: 15,
    //         ),
    //         Container(
    //           child: Row(
    //             children: [
    //               InkWell(
    //                 onTap: () {},
    //                 child: Text(
    //                   Strings.needHelp,
    //                   style: TextStyle(
    //                     decoration: TextDecoration.underline,
    //                   ),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
