import 'dart:convert';

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/bloc/select_address_type/select_address_type_bloc.dart';
import '../../config/configs.dart';
import 'package:cloud_functions/cloud_functions.dart';
import '../../services/sevices.dart';
import 'package:http/http.dart' as http;

import '../../models/models.dart';

class ProceedToPayButton extends StatelessWidget {
  final String authID;
  final double amount;
  final String razorpayOrderID;
  final String orderID;

  ProceedToPayButton({
    Key key,
    this.authID,
    this.amount,
    this.orderID,
    this.razorpayOrderID,
  }) : super(key: key);

  // Proceed To PAy Button
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          return showDialog(
            context: context,
            builder: (BuildContext context) {
              return RazorPayWeb(
                amount: amount,
                authID: authID,
                orderID: orderID,
                razorpayOrderID: razorpayOrderID,
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
