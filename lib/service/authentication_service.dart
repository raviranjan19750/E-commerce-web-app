import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:living_desire/models/localNormalCart.dart';

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

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  Future<http.Response> sendOtp(String phone) async {
    this.phone = phone;
    var res;
    try {
      Map<String, dynamic> data = {};
      res = CloudFunctionConfig.post("sendVerifyOTP/sendOTP/$phone", data);
    } catch (e) {
      print("send otp" + e.toString());
    }
    return res;
  }

  Future<HttpsCallableResult> resendOtp() async {
    HttpsCallable res =
        FirebaseFunctions.instance.httpsCallable('sendVerifyOTP');
    // res.call()
    return res.call(<String, dynamic>{"requestType": 2, "phone": this.phone});
  }

  Future<http.Response> verifyOtp(String otp) async {
    try {
      var data = {};
      return CloudFunctionConfig.post(
          "sendVerifyOTP/verifyOTP/${this.phone}/$otp", data);
    } catch (e) {
      print(e.toString());
    }
  }

  Future<http.Response> createUser() async {
    try {
      var data = {};
      return CloudFunctionConfig.post("createUser/${this.phone}", data);
    } catch (e) {
      print(e.toString());
    }
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
      final response = await CloudFunctionConfig.post(
          'sendAnonymousDataToUser/$authID', data);
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
