part of 'select_address_bloc.dart';

abstract class SelectAddressState {}

class SelectAddressDetailInitial extends SelectAddressState {}

class SelectAddressDetailLoading extends SelectAddressState {}

// ignore: must_be_immutable
class SelectAddressDetailLoadingSuccessful extends SelectAddressState {
  final Address address;

  SelectAddressDetailLoadingSuccessful(this.address);
}
