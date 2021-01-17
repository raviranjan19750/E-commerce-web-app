part of 'select_payment_bloc.dart';

abstract class SelectPaymentState {}

class LoadSelectPayment extends SelectPaymentState {
  final int paymentMode;

  LoadSelectPayment(this.paymentMode);
}

class LaunchSelectPaymentDialog extends SelectPaymentState {}
