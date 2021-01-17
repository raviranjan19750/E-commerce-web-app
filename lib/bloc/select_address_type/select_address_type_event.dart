part of 'select_address_type_bloc.dart';

abstract class SelectAddressTypeEvent {}

class InitializeLoadingSelectAddressType extends SelectAddressTypeEvent {}

class LoadBuyNowDetails extends SelectAddressTypeEvent {
  final String authID;
  final String variantID;
  final String productID;
  final String deliveryAddressID;

  LoadBuyNowDetails({
    this.authID,
    this.variantID,
    this.productID,
    this.deliveryAddressID,
  });
}

class LoadNormalCartDetails extends SelectAddressTypeEvent {
  final String authID;
  final int totalItems;
  final String deliveryAddressID;

  LoadNormalCartDetails({
    this.authID,
    this.totalItems,
    this.deliveryAddressID,
  });
}

class LoadBulkOrderCartDetails extends SelectAddressTypeEvent {
  final String totalItems;
  final String authID;
  final bool isSampleRequested;
  final String deliveryAddressID;
  final bool isBulkOrderCart;

  LoadBulkOrderCartDetails({
    this.totalItems,
    this.authID,
    this.deliveryAddressID,
    this.isSampleRequested,
    this.isBulkOrderCart,
  });
}

class CreatePaymentOrder extends SelectAddressTypeEvent {
  final String authID;
  final double amount;

  CreatePaymentOrder({
    this.amount,
    this.authID,
  });
}

class PaymentMethod extends SelectAddressTypeEvent {
  final int paymentMode;

  PaymentMethod({this.paymentMode});
}
