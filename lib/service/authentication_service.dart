import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:living_desire/models/user.dart';
// import 'pa';

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  String phone;
  String uid;
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
}
