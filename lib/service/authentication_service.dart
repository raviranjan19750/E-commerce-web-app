import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:living_desire/models/localNormalCart.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/models/user_detail.dart';
import 'package:living_desire/service/sharedPreferences.dart';
// import 'pa';

class LogOutFailure implements Exception {}

class LoginWithTokenFailure implements Exception {}

class SignInANonymouslyFailute implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  String phone;
  String uid;
  final _wishlist = Hive.box<Map<String, String>>('wishlist_items');
  final _cartlist = Hive.box<NormalCartLocal>('cart_items');
  final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');

  // final _cartlist = Hive.box<Product>('cart_items');
  // final _customCartlist = Hive.box<Product>('wishlist_items');

  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<ConfirmationResult> loginWithPhoneNumber(String phone) async {
    return await _firebaseAuth.signInWithPhoneNumber("+91" + phone);
  }

  // Future<firebase_auth.UserCredential> verifyOTP(
  //     String verification, firebase_auth.ConfirmationResult result) async {
  //   return await result.confirm(verification);
  // }
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  Future<HttpsCallableResult> sendOtp(String phone) async {
    HttpsCallable res =
        FirebaseFunctions.instance.httpsCallable('sendVerifyOTP');
    this.phone = phone;
    // res.call()
    return res.call(<String, dynamic>{"requestType": 1, "phone": phone});
  }

  Future<HttpsCallableResult> resendOtp() async {
    HttpsCallable res =
        FirebaseFunctions.instance.httpsCallable('sendVerifyOTP');
    // res.call()
    return res.call(<String, dynamic>{"requestType": 2, "phone": this.phone});
  }

  Future<HttpsCallableResult> verifyOtp(String otp) async {
    HttpsCallable res =
        FirebaseFunctions.instance.httpsCallable('sendVerifyOTP');
    // res.call()
    return res.call(
        <String, dynamic>{"requestType": 3, "phone": this.phone, "otp": otp});
  }

  // auth id phone nu
  // function name?
  Future<HttpsCallableResult> createUser() async {
    HttpsCallable res = FirebaseFunctions.instance.httpsCallable('createUser');
    // res.call()
    return res.call(<String, dynamic>{"phone": this.phone});
  }

  Future<void> signInAnony() async {
    try {
      await _firebaseAuth.signInAnonymously();
    } on Exception {
      throw SignInANonymouslyFailute();
    }
  }

  Future<void> sendWishlistData(String authID) async {
    try {
      Map<dynamic, Map<String, String>> wsh = _wishlist.toMap();
      Map<dynamic, NormalCartLocal> cart = _cartlist.toMap();
      Map<dynamic, CustomCartLocal> customCart = _customcartlist.toMap();

      List<Map<String, String>> wshlist = [];
      List<NormalCartLocal> cartlist = [];
      List<CustomCartLocal> customcartlist = [];

      wsh.forEach((key, value) {
        wshlist.add(value);
        json.encode(value);
      });
      cart.forEach((key, value) {
        cartlist.add(value);
      });
      customCart.forEach((key, value) {
        customcartlist.add(value);
      });
      var data = {
        "authID": authID,
        "wishlistData": wshlist,
        "normalCartData": cartlist,
        "customCartData": customcartlist,
      };
      print(data);
      print(json.encode(data));
      final response = await http.post(
        FunctionConfig.host + 'sendAnonymousDataToUser/$authID',
        body: jsonEncode(data),
        headers: {"Content-Type": "application/json"},
        // body: data
      );
      print("===================>     " + response.body);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> signInWithToken({String token}) async {
    assert(token != null);
    try {
      firebase_auth.UserCredential user =
          await _firebaseAuth.signInWithCustomToken(token);

      // UserPreferences().setAuthID(user.user.uid);
      this.uid = user.user.uid;
      await sendWishlistData(user.user.uid);
    } on Exception {
      throw LoginWithTokenFailure();
    }
  }

  // Future<String> sendUserDetailsData(String name, String email) async {
  //   var data = {
  //     "name": name,
  //     "email": email,
  //     "phone": this.phone,
  //   };
  //   final response = await http.post(
  //     FunctionConfig.host + 'manageCustomerInfo/${this.uid}',
  //     body: jsonEncode(data),
  //     headers: {"Content-Type": "application/json"},
  //   );
  //   return response.body;
  // }

  // Future<UserDetail> getUserDetailsData(String uid) async {
  //   final response = await http.get(
  //     FunctionConfig.host + 'manageCustomerInfo/$uid',
  //   );
  //   Map<String, dynamic> data = jsonDecode(response.body);
  //   print("!!!!!!!!!!!!!!!!! " + response.body.toString());
  //   return UserDetail.fromJson(data);
  // }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      // TODO
      // Go back to initial state
    } on Exception {
      throw LogOutFailure();
    }
  }
}
