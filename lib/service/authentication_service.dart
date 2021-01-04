import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:living_desire/bloc/sign_in/sign_in_bloc.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/service/sharedPreferences.dart';
// import 'pa';

class LogOutFailure implements Exception {}

class LoginWithTokenFailure implements Exception {}

class SignInANonymouslyFailute implements Exception {}

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  String phone;
  String uid;
  final _wishlist = Hive.box<Product>('wishlist_items');

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

  Future<void> sendWishlistData() async {
    try {
      print(_wishlist.toMap().toString());
    } catch (e) {}
  }

  Future<void> signInWithToken({String token}) async {
    assert(token != null);
    try {
      firebase_auth.UserCredential user =
          await _firebaseAuth.signInWithCustomToken(token);

      // UserPreferences().setAuthID(user.user.uid);
      await sendWishlistData();
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

// extension on firebase_auth.User {
//   User get toUser {
//     return User(id: uid, email: email, name: displayName, photo: photoURL);
//   }
// }
