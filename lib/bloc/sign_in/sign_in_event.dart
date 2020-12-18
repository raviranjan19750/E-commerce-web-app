part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SendOTP extends SignInEvent {
  final String phoneNumber;

  SendOTP({@required this.phoneNumber}) : assert(phoneNumber != null);
}

class VerifyOTP extends SignInEvent {
  final String verificationCode;
  VerifyOTP({@required this.verificationCode})
      : assert(verificationCode != null);
}

class ResendOTP extends SignInEvent {
  ResendOTP();
}

class LoginStatus extends SignInEvent {
  LoginStatus();
}

class SignIn extends SignInEvent {
  final String token;

  SignIn(@required this.token);
}

class SignOut extends SignInEvent {}
