import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:living_desire/service/authentication_service.dart';
import 'package:meta/meta.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {

  final AuthenticationRepository authService;
  ConfirmationResult result;


  SignInBloc({this.authService}) :
        assert(authService != null),
        super(SignInInitial());

  @override
  Stream<SignInState> mapEventToState(
    SignInEvent event,
  ) async* {
    if (event is SendOTP) {
      yield* _sendOtp(event);
    } else if (event is VerifyOTP) {
      yield* _verifyingOtp(event);
    }
  }

  Stream<SignInState> _sendOtp(SendOTP event) async* {
    yield SendingOTP();
    try {
      result = await authService.loginWithPhoneNumber(event.phoneNumber);
      yield OTPSentToUser();
    } catch (e) {
      print(e);
      yield SendingOTPFailed();
    }
  }

  Stream<SignInState> _verifyingOtp(VerifyOTP event) async* {
    yield VerifyingOTP();
    try {
      if (result != null) {
        UserCredential credential = await result.confirm(event.verificationCode);
        yield VerificationSuccess();
      } else {
        throw Exception();
      }
    } catch (e) {
      yield VerificationFailure();
      await Future.delayed(Duration(seconds: 2));
      yield SignInInitial();
    }
  }
}
