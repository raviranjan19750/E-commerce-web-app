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

class GetUserDetailsEvent extends SignInEvent {
  final String email;
  final String name;
  final String phone;
  final String uid;

  GetUserDetailsEvent(
    this.email,
    this.name,
    this.phone,
    this.uid,
  ) : assert(name != null && email != null && phone != null && uid != null);
}

class MovetoUserDetailEvent extends SignInEvent {
  MovetoUserDetailEvent();
}
