import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/config/strings.dart';

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
    await CloudFunctionConfig.get('manageWallet/wallet-amount/$authID');
    print("Referral Code  :  " + response.body);

    if(response.statusCode == 200){


      Map<String,dynamic> map = jsonDecode(response.body);

      walletAmount = map['ununsedAmount'];
      walletAmountUsed = map['usedAmount'];


    }

  }


}