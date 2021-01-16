part of 'select_payment_bloc.dart';

abstract class SelectPaymentEvent {}

class GetSelectPayment extends SelectPaymentEvent {
  final int paymentMode;

  GetSelectPayment(this.paymentMode);
}

class LoadSelectPaymentDialog extends SelectPaymentEvent {}
