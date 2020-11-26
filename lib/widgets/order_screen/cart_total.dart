import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';

class CartTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 100% Purchase Protection Container
            Container(
              child: Row(
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
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Strings.subTotal + ' (total no. of products)'),
                  Text('Subatotal Amount'),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Strings.deliveryCharges),
                  Text('Delivery Charges'),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Strings.discount),
                  Text('Discount'),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.black,
              thickness: 0.3,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(Strings.total),
                  Text('Total'),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Palette.secondaryColor,
              ),
              // Place Order Button
              child: InkWell(
                onTap: () {},
                child: Text(
                  Strings.placeOrder,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Text(
              Strings.selectAddressNextStep,
              style: TextStyle(
                fontSize: 12,
                color: Colors.black45,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
