part of 'select_address_bloc.dart';

enum SelectAddressStateType {
  BUY_NOW,
  NORMAL_CART,
  BULK_ORDER,
  SUCCESS,
  FAILURE
}

abstract class SelectAddressState {
  final SelectAddressStateType type;

  SelectAddressState(this.type);
}

class SelectAddressDetailInitial extends SelectAddressState {
  SelectAddressDetailInitial(SelectAddressStateType type) : super(type);
}

class SelectAddressDetailLoading extends SelectAddressState {
  SelectAddressDetailLoading(SelectAddressStateType type) : super(type);
}

// ignore: must_be_immutable
class SelectAddressDetailLoadingSuccessful extends SelectAddressState {
  final Address address;

  SelectAddressDetailLoadingSuccessful(this.address) : super(null);
}
