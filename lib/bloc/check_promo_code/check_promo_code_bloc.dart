import 'dart:async';
import 'package:living_desire/models/check_promo_code_availability.dart';
import 'package:bloc/bloc.dart';
import 'package:living_desire/DBHandler/promo_code_repository.dart';
part 'check_promo_code_event.dart';
part 'check_promo_code_state.dart';

class CheckPromoCodeBloc
    extends Bloc<PromoCodeAvailabilityEvent, PromoCodeAvailabilityState> {
  final PromoCodeRepository promoCodeRepository;

  CheckPromoCodeBloc({this.promoCodeRepository})
      : assert(promoCodeRepository != null),
        super(null);

  @override
  Stream<PromoCodeAvailabilityState> mapEventToState(
    PromoCodeAvailabilityEvent event,
  ) async* {
    if (event is CheckingPromoCodeAvailability) yield* checkAvailability(event);
  }

  Stream<PromoCodeAvailabilityState> checkAvailability(
      CheckingPromoCodeAvailability event) async* {
    yield PromoCodeDetailAvailabilityChecking();

    try {
      var promoCodeAvailabilityResponse =
          await promoCodeRepository.checkPromoCodeAvailability(
        authID: event.authID,
        payingAmount: event.payingAmount,
        paymentMode: event.paymentMode,
        promoCode: event.promoCode,
        deliveryCharges: event.deliveryCharges,
        walletAmount: event.walletAmount,
      );
      yield PromoCodeDetailAvailabilityCheckingSuccessful(
          promoCodeAvailabilityResponse);
    } catch (e) {
      print(e.toString());
      yield PromoCodeDetailAvailabilityCheckingFailure();
    }
  }
}
