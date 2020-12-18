import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:living_desire/service/authentication_service.dart';
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
      yield* _sendOtp1(event);
    } else if (event is VerifyOTP) {
      yield* _verifyotp(event);
    } else if (event is ResendOTP) {
      yield* _resendotp(event);
    }
  }

  // Stream<SignInState> _createUser(SignIn event) async* {
  //   try {
  //     HttpsCallableResult res = await authService.createUser(event.token);
  //     var map = jsonDecode(res.data);
  //     print("inside signinsucc" + res.data.toString());
  //     // int code = res.data['responseCode'];
  //     int code = map['responseCode'];
  //     print("Create user code" + code.toString());
  //     switch (code) {
  //       case 200:
  //         print("new user created... signing in");
  //         print(map['token']);
  //         String customToken = map['token'];
  //         await authService.signInWithToken(token: customToken);
  //         yield SignInSuccessful();
  //         break;
  //       case 401:
  //         break;
  //       case 402:
  //         print("User already exists so signing in with customToken");
  //         await authService.signInWithToken(token: event.token);
  //         yield SignInSuccessful();
  //         break;
  //       case 403:
  //         break;
  //       default:
  //     }
  //   } catch (e) {
  //     print("error in create user");
  //   }
  // }

  Future<void> newUserCreation() async {
    try {
      HttpsCallableResult res = await authService.createUser();
      print("inside signinsucc" + res.data.toString());
      // var map = jsonDecode(res.data);
      int code = res.data['responseCode'];
      // int code = map['responseCode'];
      print("Create user code" + code.toString());
      switch (code) {
        case 200:
          print("new user created... signing in");
          print(res.data['token']);
          String customToken = res.data['token'];
          await authService.signInWithToken(token: customToken);
          print("user signed in....");
          break;
        case 401:
          break;
        case 402:
          // print("User already exists so signing in with customToken");
          // String customToken = map['token'];
          // await authService.signInWithToken(token: customToken);
          break;
        case 403:
          break;
        default:
      }
    } catch (e) {
      print("error in create user");
    }
  }

  Stream<SignInState> _sendOtp1(SendOTP event) async* {
    yield SendingOTP();
    try {
      HttpsCallableResult res = await authService.sendOtp(event.phoneNumber);
      // print(res.data.toString());
      // int code = int.parse(res.data['responseCode']);
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
      // int code = res.data['responseCode'];
      int code = map['responseCode'];
      print(" verify otp response : " + code.toString());
      switch (code) {
        case 200:
          this.isSignedIn = true;
          // print(
          //     "Currentu LoggedIn UserID ${FirebaseAuth.instance.currentUser.uid}");
          await newUserCreation();
          yield VerificationSuccess();
          break;

        case 401:
          yield VerificationFailure();
          break;
        case 402:
          // print("error")
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
      print(res.data.toString());
      var map = jsonDecode(res.data);
      // int code = res.data['responseCode'];
      int code = map['responseCode'];

      print(" resend otp response : " + code.toString());
      switch (code) {
        case 200:
          yield ResendingOTPSuccess();
          break;

        case 401:
          yield ResendingOTPFailure();
          break;
        case 402:
          // print("error")
          yield ResendingOTPFailure();
          break;

        case 404:
          yield ResendingOTPFailure();
          break;
      }
    } catch (e) {}
  }

  Stream<SignInState> _loginStatus(LoginStatus event) async* {
    if (this.isSignedIn) {
      yield LoggedInState();
    } else {
      yield LoggedOutState();
    }
  }
}
