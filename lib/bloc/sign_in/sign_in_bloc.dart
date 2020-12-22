import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:living_desire/service/sharedPreferences.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  final AuthenticationRepository authService;
  ConfirmationResult result;
  bool isSignedIn = false;

  SignInBloc({this.authService})
      : assert(authService != null),
        super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SendOTP) {
      yield* _sendOtp(event);
    } else if (event is VerifyOTP) {
      yield* _verifyotp(event);
    } else if (event is ResendOTP) {
      yield* _resendotp(event);
    } else if (event is SignOut) {
      yield SignInInitial();
    }
  }

  Future<void> newUserCreation() async {
    try {
      HttpsCallableResult res = await authService.createUser();
      // print("inside signinsucc" + res.data.toString());
      // var map = jsonDecode(res.data);
      int code = res.data['responseCode'];
      // int code = map['responseCode'];
      // print("Create user code" + code.toString());
      switch (code) {
        case 200:
          // print("new user created... signing in");
          // print(res.data['token']);
          String customToken = res.data['token'];
          // TODO :
          // add auth id to local storage
          // push local changesd to firebase
          await authService.signInWithToken(token: customToken);
          UserPreferences().setAuthID(customToken);
          UserPreferences().AuthID;
          print("user auth id is ${UserPreferences().AuthID}");
          print("user signed in....");
          break;
        case 401:
          break;
        case 402:
          break;
        case 403:
          break;
        default:
      }
    } catch (e) {
      print("error in create user");
    }
  }

  Stream<SignInState> _sendOtp(SendOTP event) async* {
    yield SendingOTP();
    try {
      HttpsCallableResult res = await authService.sendOtp(event.phoneNumber);
      var map = jsonDecode(res.data);
      int code = map['responseCode'];
      print("response : " + code.toString());
      switch (code) {
        case 200:
          yield OTPSentToUser();
          break;

        case 401:
          yield SendingOTPFailed();
          break;
        case 403:
          yield SendingOTPFailed();
          break;
      }
    } catch (e) {
      print(e);
      yield SendingOTPFailed();
    }
  }

  Stream<SignInState> _verifyotp(VerifyOTP event) async* {
    yield VerifyingOTP();
    try {
      HttpsCallableResult res =
          await authService.verifyOtp(event.verificationCode);
      print(res.data.toString());
      var map = jsonDecode(res.data);
      int code = map['responseCode'];
      print(" verify otp response : " + code.toString());
      switch (code) {
        case 200:
          this.isSignedIn = true;
          await newUserCreation();
          yield VerificationSuccess();
          break;

        case 401:
          yield VerificationFailure();
          break;
        case 402:
          yield VerificationFailure();
          break;

        case 404:
          yield VerificationFailure();
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<SignInState> _resendotp(ResendOTP event) async* {
    yield ResendingOTP();
    try {
      HttpsCallableResult res = await authService.resendOtp();
      var map = jsonDecode(res.data);
      int code = map['responseCode'];

      // print(" resend otp response : " + code.toString());
      switch (code) {
        case 200:
          yield ResendingOTPSuccess();
          break;

        case 401:
          yield ResendingOTPFailure();
          break;
        case 402:
          yield ResendingOTPFailure();
          break;

        case 404:
          yield ResendingOTPFailure();
          break;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
