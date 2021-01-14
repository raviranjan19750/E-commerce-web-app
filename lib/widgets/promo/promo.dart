import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:living_desire/DBHandler/promocode_repository.dart';
import 'package:living_desire/bloc/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PromoCodeLabel extends StatefulWidget {
  @override
  _PromoCodeLabelState createState() => _PromoCodeLabelState();
}

class _PromoCodeLabelState extends State<PromoCodeLabel> {
  String code = "";
  String res = " ";
  TextEditingController _codeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(10.0),
      // height: 250,
      // width: 500,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Do You have a PROMO CODE ??",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _codeController,
            validator: (val) => val.isEmpty ? "enter code " : null,
            onChanged: (val) {
              setState((() => code = val));
            },
            decoration: InputDecoration(
                labelText: 'Enter Promo Code here',
                filled: true,
                focusColor: Colors.pink),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RaisedButton(
                color: Colors.black,
                onPressed: _codeController.text.length > 6
                    ? () async {
                        String ans = await PromoCodeUtils()
                            .manageDiscountCoupons(
                                BlocProvider.of<AuthenticationBloc>(context)
                                    .state
                                    .user
                                    .uid,
                                _codeController.text);
                        setState(() {
                          res = jsonDecode(ans)['message'];
                        });
                      }
                    : null,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 40,
                  width: 280,
                  child: Text(res),
                ),
              ),
            ],
          ),
        ],
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
    );
  }
}
