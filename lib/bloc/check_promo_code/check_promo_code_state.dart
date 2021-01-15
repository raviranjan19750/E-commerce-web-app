part of 'check_promo_code_bloc.dart';

abstract class PromoCodeAvailabilityState {}

class PromoCodeAvailabilityInitial extends PromoCodeAvailabilityState {}

class PromoCodeDetailAvailabilityChecking extends PromoCodeAvailabilityState {}

class PromoCodeDetailAvailabilityCheckingSuccessful
    extends PromoCodeAvailabilityState {
  final CheckPromoCodeAvailability checkPromoCodeAvailability;

  PromoCodeDetailAvailabilityCheckingSuccessful(
      this.checkPromoCodeAvailability);
}

class PromoCodeDetailAvailabilityCheckingFailure
    extends PromoCodeAvailabilityState {}
