part of 'manage_addresses_bloc.dart';

abstract class ManageAddresesState {}

class AddressDetailInitial extends ManageAddresesState {}

class AddressDetailLoading extends ManageAddresesState {}

// ignore: must_be_immutable
class AddressDetailLoadingSuccessful extends ManageAddresesState {
  final List<Address> addresses;

  AddressDetailLoadingSuccessful(this.addresses);
}

class AddressDetailLoadingFailure extends ManageAddresesState {}
