part of 'sign_in_bloc.dart';

@immutable
abstract class SignInState {}

class SignInInitial extends SignInState {}

// Loading OTP
class SendingOTP extends SignInState {}

class SendingOTPFailed extends SignInState {}

class OTPSentToUser extends SignInState {}

class VerifyingOTP extends SignInState {}

class VerificationSuccess extends SignInState {}

class VerificationFailure extends SignInState {}
