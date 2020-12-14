import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:meta/meta.dart';

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
    if (event is LoginStatus) {
      yield* _loginStatus(event);
    }
  }

  Stream<SignInState> _sendOtp1(SendOTP event) async* {
    yield SendingOTP();
    try {
      HttpsCallableResult res = await authService.sendOtp(event.phoneNumber);
      print(res.data.toString());
      int code = res.data['responseCode'];
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
      int code = res.data['responseCode'];
      print(" verify otp response : " + code.toString());
      switch (code) {
        case 200:
          this.isSignedIn = true;
          print(this.isSignedIn);
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
    } catch (e) {}
  }

  Stream<SignInState> _resendotp(ResendOTP event) async* {
    yield ResendingOTP();
    try {
      HttpsCallableResult res = await authService.resendOtp();
      print(res.data.toString());
      int code = res.data['responseCode'];
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
