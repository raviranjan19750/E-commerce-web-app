part of 'select_address_type_bloc.dart';

abstract class SelectAddressTypeState {}

class SelectAddressTypeDetailInitial extends SelectAddressTypeState {}

class SelectAddressTypeDetailLoading extends SelectAddressTypeState {}

class BuyNowDetailLoadingInitial extends SelectAddressTypeState {}

class BuyNowDetailLoadingSucessfull extends SelectAddressTypeState {
  final BuyNowDetails buyNowDetails;

  BuyNowDetailLoadingSucessfull({
    this.buyNowDetails,
  });
}

class NormalCartDetailLoadingInitial extends SelectAddressTypeState {}

class BuyNowDetailLoadingFailure extends SelectAddressTypeState {}

class NormalCartDetailLoadingFailure extends SelectAddressTypeState {}

class NormalCartDetailLoadingSuccessfull extends SelectAddressTypeState {
  final NormalCartDetails normalCartDetails;

  NormalCartDetailLoadingSuccessfull({
    this.normalCartDetails,
  });
}

class CreatePaymentOrderDetailLoadingInitial extends SelectAddressTypeState {}

class CreatePaymentOrderDetailLoadingFailure extends SelectAddressTypeState {}

class CreatePaymentOrderDetailLoadingSuccessfull
    extends SelectAddressTypeState {
  final String razorpayOrderID;
  final String orderID;
  CreatePaymentOrderDetailLoadingSuccessfull({
    this.orderID,
    this.razorpayOrderID,
  });
}

class BulkOrderDetailLoadingSuccessfull extends SelectAddressTypeState {
  final String authID;
  final String totalItems;
  final bool isSampleRequested;
  final String deliveryAddressID;
  final bool isBulkOrderCart;

  BulkOrderDetailLoadingSuccessfull({
    this.authID,
    this.totalItems,
    this.isSampleRequested,
    this.deliveryAddressID,
    this.isBulkOrderCart,
  });
}

class PaymentMethodLoadingSuccessfull extends SelectAddressTypeState {
  final int paymentMode;

  PaymentMethodLoadingSuccessfull({this.paymentMode});
}

class LaunchSelectPaymentDialog extends SelectAddressTypeState {}
