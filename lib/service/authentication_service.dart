import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:living_desire/models/localNormalCart.dart';
import 'package:living_desire/models/localwishlist.dart';

class LogOutFailure implements Exception {}

class LoginWithTokenFailure implements Exception {}

class SignInANonymouslyFailute implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  String phone;
  String uid;
  final _wishlist = Hive.box<WishlistLocal>('wishlist_items');
  final _cartlist = Hive.box<NormalCartLocal>('cart_items');
  final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');

  // final _cartlist = Hive.box<Product>('cart_items');
  // final _customCartlist = Hive.box<Product>('wishlist_items');

  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Future<ConfirmationResult> loginWithPhoneNumber(String phone) async {
    await _firebaseAuth.setPersistence(firebase_auth.Persistence.LOCAL);
    return await _firebaseAuth.signInWithPhoneNumber("+91" + phone);
  }

  void reloadUser() async {
    await _firebaseAuth.setPersistence(firebase_auth.Persistence.LOCAL);
    await _firebaseAuth.currentUser.reload();
  }

  Stream<User> get user {
    // _firebaseAuth.userChanges()
    return _firebaseAuth.userChanges().map((firebaseUser) {
      return firebaseUser;
    });
  }

  Future<http.Response> sendOtp(String phone) async {
    await _firebaseAuth.setPersistence(firebase_auth.Persistence.LOCAL);
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
      Map<dynamic, WishlistLocal> wsh = _wishlist.toMap();
      Map<dynamic, NormalCartLocal> cart = _cartlist.toMap();
      Map<dynamic, CustomCartLocal> customCart = _customcartlist.toMap();

      // List<WishlistLocal> wshlist = [];
      // List<NormalCartLocal> cartlist = [];
      // List<CustomCartLocal> customcartlist = [];
      List<Map<String, dynamic>> wshlist = [];
      List<Map<String, dynamic>> cartlist = [];
      List<Map<String, dynamic>> customcartlist = [];
      // wsh.forEach((key, value) {
      //   wshlist.add(value);
      //   // json.encode(value);
      // });
      wsh.forEach((key, value) {
        wshlist
            .add({"productID": value.productID, "variantID": value.variantID});
      });
      cart.forEach((key, value) {
        cartlist.add({
          "productID": value.productID,
          "variantID": value.variantID,
          "quantity": value.quantity
        });
      });
      customCart.forEach((key, value) {
        customcartlist.add({
          "productID": value.productId,
          "variantID": value.variantId,
          "quantity": value.quantity,
          "productType": value.productType,
          "productSubType": value.productSubType,
          "size": value.size,
          "colour": value.colour,
          "description": value.description,
          "images": value.images
        });
      });
      var data = {
        "authID": authID,
        "wishlistData": wshlist,
        "normalCartData": cartlist,
        "customCartData": customcartlist,
      };
      // print(data);
      // print(json.encode(data));
      LOG.i("send anonymous data to user : $data");
      final response = await CloudFunctionConfig.post(
          'sendAnonymousDataToUser/$authID', data);
    } catch (e) {
      print("send anony error : " + e.toString());
    }
  }

  Future<void> signInWithToken({String token}) async {
    LOG.i("token in sigin in with token: $token");
    assert(token != null);
    try {
      await _firebaseAuth.setPersistence(firebase_auth.Persistence.LOCAL);
      firebase_auth.UserCredential user =
          await _firebaseAuth.signInWithCustomToken(token);

      // UserPreferences().setAuthID(user.user.uid);
      this.uid = user.user.uid;
      await sendWishlistData(user.user.uid);
    } on Exception {
      print(Exception);
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
