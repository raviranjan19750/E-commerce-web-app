import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/config/function_config.dart';

class MyWalletProvider with ChangeNotifier{



  int walletAmount;
  int walletAmountUsed;

  bool isInitialize = false;

  void initWallet() async {

    String authID = FirebaseAuth.instance.currentUser.uid;

    await getWalletDetails(authID);

    isInitialize = true;

    notifyListeners();

  }

  Future<void> getWalletDetails(String authID) async{

    final response =
    await http.get(FunctionConfig.host + 'manageWallet/wallet-amount/$authID', headers: {"Content-Type": "application/json"},);

    print("Referral Code  :  " + response.body);

    if(response.statusCode == 200){


      Map<String,dynamic> map = jsonDecode(response.body);

      walletAmount = map['ununsedAmount'];
      walletAmountUsed = map['usedAmount'];


    }

  }


}