part of 'sign_in_bloc.dart';

@immutable
abstract class SignInEvent {}

class SendOTP extends SignInEvent {
  final String phoneNumber;

  SendOTP({@required this.phoneNumber}) : assert(phoneNumber != null);
}

class VerifyOTP extends SignInEvent {
  final String verificationCode;
  VerifyOTP({@required this.verificationCode }) : assert(verificationCode != null);
}

class SignOut extends SignInEvent {}