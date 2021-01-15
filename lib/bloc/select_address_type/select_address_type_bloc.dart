import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/DBHandler/select_address_type_repository.dart';
import 'package:living_desire/models/models.dart';
part 'select_address_type_event.dart';
part 'select_address_type_state.dart';

class SelectAddressTypeBloc
    extends Bloc<SelectAddressTypeEvent, SelectAddressTypeState> {
  final SelectAddressTypeRepository selectAddressTypeRepository;

  SelectAddressTypeBloc({this.selectAddressTypeRepository}) : super(null);

  @override
  Stream<SelectAddressTypeState> mapEventToState(
    SelectAddressTypeEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadBuyNowDetails) {
      yield* getBuyNowDetails(event);
    } else if (event is LoadNormalCartDetails) {
      yield* getNormalCartDetails(event);
    } else if (event is LoadBulkOrderCartDetails) {
      yield BulkOrderDetailLoadingSuccessfull(
        authID: event.authID,
        deliveryAddressID: event.deliveryAddressID,
        isSampleRequested: event.isSampleRequested,
        totalItems: event.totalItems,
        isBulkOrderCart: event.isBulkOrderCart,
      );
    } else if (event is CreatePaymentOrder) {
      yield* createPaymentOrder(event);
    } else if (event is PaymentMethod) {
      yield PaymentMethodLoadingSuccessfull(paymentMode: event.paymentMode);
    } else if (event is LoadSelectPaymentDialog) {
      yield LaunchSelectPaymentDialog();
    }
  }

  Stream<SelectAddressTypeState> createPaymentOrder(
      CreatePaymentOrder event) async* {
    yield CreatePaymentOrderDetailLoadingInitial();
    try {
      var data = await selectAddressTypeRepository.createPaymentOrder(
        authID: event.authID,
        amount: event.amount,
      );

      yield CreatePaymentOrderDetailLoadingSuccessfull(
        orderID: data["orderID"],
        razorpayOrderID: data["razorpayOrderID"],
      );
    } catch (e) {
      yield CreatePaymentOrderDetailLoadingFailure();
    }
  }

  Stream<SelectAddressTypeState> getBuyNowDetails(
      LoadBuyNowDetails event) async* {
    yield BuyNowDetailLoadingInitial();
    try {
      BuyNowDetails buyNowDetails =
          await selectAddressTypeRepository.getBuyNowDetails(
        authID: event.authID,
        deliveryAddressID: event.deliveryAddressID,
        productID: event.productID,
        variantID: event.variantID,
      );

      yield BuyNowDetailLoadingSucessfull(buyNowDetails: buyNowDetails);
    } catch (e) {
      yield BuyNowDetailLoadingFailure();
    }
  }

  Stream<SelectAddressTypeState> getNormalCartDetails(
      LoadNormalCartDetails event) async* {
    yield NormalCartDetailLoadingInitial();
    try {
      NormalCartDetails normalCartDetails =
          await selectAddressTypeRepository.getNormalCartDetails(
        authID: event.authID,
        deliveryAddressID: event.deliveryAddressID,
      );

      yield NormalCartDetailLoadingSuccessfull(
          normalCartDetails: normalCartDetails);
    } catch (e) {
      yield NormalCartDetailLoadingFailure();
    }
  }
}
