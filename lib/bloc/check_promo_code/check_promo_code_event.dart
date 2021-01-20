part of 'check_promo_code_bloc.dart';

abstract class PromoCodeAvailabilityEvent {}

class CheckingPromoCodeAvailabilityInitial extends PromoCodeAvailabilityEvent {
  CheckingPromoCodeAvailabilityInitial();
}

class CheckingPromoCodeAvailability extends PromoCodeAvailabilityEvent {
  final String authID;
  final int paymentMode;
  final double payingAmount;
  final String promoCode;
  final double deliveryCharges;
  final double walletAmount;

  CheckingPromoCodeAvailability({
    this.authID,
    this.payingAmount,
    this.paymentMode,
    this.promoCode,
    this.walletAmount,
    this.deliveryCharges,
  });
}
