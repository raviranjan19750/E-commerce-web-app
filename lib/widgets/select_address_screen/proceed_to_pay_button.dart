import 'dart:convert';

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/bloc/select_address_type/select_address_type_bloc.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import '../../config/configs.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../services/sevices.dart';
import 'package:http/http.dart' as http;

import '../../models/models.dart';

class ProceedToPayButton extends StatelessWidget {
  final String authID;
  final double amount;
  String razorpayOrderID;
  String orderID;
  final int paymentMode;

  ProceedToPayButton({
    Key key,
    this.authID,
    this.amount,
    this.orderID,
    this.paymentMode,
    this.razorpayOrderID,
  }) : super(key: key);

  // Proceed To PAy Button
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // try {
          //   var params = {"amount": 100};
          //   print(params);
          //   final response = await CloudFunctionConfig.post(
          //       'managePayments/create-order/FtkJJ0IK1tYpC8ldkmlLVgNDlS12',
          //       params);
          //   // http.post(
          //   //     FunctionConfig.host + 'managePayments/create-order/${authID}',
          //   //     body: params);
          //   //LOG.i("Http Post request create order manage payments");
          //   if (response.statusCode == 200) {
          //     orderID = (jsonDecode(response.body))["orderID"];
          //     razorpayOrderID = (jsonDecode(response.body))["razorpayOrderID"];
          //     print(orderID);
          //     print(razorpayOrderID);

          //     // return (jsonDecode(response.body));
          //   } else {
          //     print(response.statusCode);
          //     print(response.body);
          //   }

          // } catch (e) {
          //   print(e.toString());
          //   throw Exception(e);
          // }

          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return RazorPayWeb(
                paymentMode: paymentMode,
                amount: 100,
                authID: "FtkJJ0IK1tYpC8ldkmlLVgNDlS12",
                orderID: "sample_orderID",
                razorpayOrderID: "order_GPDhFi29V4QgjJ",
              );
            },
          );
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
}
