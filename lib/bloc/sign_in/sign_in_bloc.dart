import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:living_desire/DBHandler/promocode_repository.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:living_desire/service/sharedPreferences.dart';
import 'package:living_desire/service/user_details.dart';
import 'package:meta/meta.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

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
    } else if (event is GetUserDetailsEvent) {
      yield* _userdetail(event);
    }
  }

  Future<int> newUserCreation() async {
    try {
      var res = await authService.createUser();
      // HttpsCallableResult res = await authService.createUser();
      // print("inside signinsucc" + res.data.toString());
      // var map = jsonDecode(res.data);
      // int code = res.data['responseCode'];
      int code = res.statusCode;
      // int code = map['responseCode'];
      // print("Create user code" + code.toString());
      switch (code) {
        case 200:
          // print("new user created... signing in");
          // print(res.data['token']);
          String customToken = jsonDecode(res.body)['token'];
          int usertype = jsonDecode(res.body)['userType'];
          // TODO :
          // add auth id to local storage
          // push local changesd to firebase
          // await authService.sendWishlistData();
          await authService.signInWithToken(token: customToken);
          // UserPreferences().setAuthID(customToken);
          UserPreferences().AuthID;
          return usertype;
          // print("user auth id is ${UserPreferences().AuthID}");
          // print("user signed in....");
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
      var res = await authService.sendOtp(event.phoneNumber);
      int code = res.statusCode;
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
      var res = await authService.verifyOtp(event.verificationCode);
      int code = res.statusCode;
      print(" verify otp response : " + code.toString());
      switch (code) {
        case 200:
          this.isSignedIn = true;
          int usrType = await newUserCreation();
          if (usrType == 101) {
            var refCode =
                await PromoCodeUtils().getUserReferallCode(authService.uid);
            print(refCode.toString());
            yield VerificationSuccessNew(refCode['referralCode']);
          } else if (usrType == 102) yield VerificationSuccess();
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
      // var map = jsonDecode(res.data);
      // int code = map['responseCode'];
      int code = res.data['responseCode'];
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

  Stream<SignInState> _userdetail(GetUserDetailsEvent event) async* {
    yield SendingOTP();
    try {
      var res = await UserdetailsRepository()
          .sendUserDetailsData(event.name, event.email, event.phone, event.uid);
      // var map = jsonDecode(res.data);
      print("response : " + res['message']);
      switch (res['message']) {
        case "OK":
          // print(event.uid);
          // await authService.logout();
          await authService.signInWithToken(token: res['customToken']);

          yield GetUserDetailSuccessful();
          break;

        case "Failure":
          yield GetUserDetailFaliure();
          break;
      }
    } catch (e) {
      print(e);
      yield GetUserDetailFaliure();
    }
  }
}
