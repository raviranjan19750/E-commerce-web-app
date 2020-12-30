part of 'select_address_bloc.dart';

abstract class SelectAddressEvent {}

class InitializeLoadingSelectAddress extends SelectAddressEvent {}

class LoadAddress extends SelectAddressEvent {
  final Address address;

  LoadAddress(
    this.address,
  );
}
