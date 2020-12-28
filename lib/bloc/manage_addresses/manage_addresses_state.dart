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

class AddAddressDetailLoading extends ManageAddresesState {}

class AddAddressDetailLoadingSuccesfull extends ManageAddresesState {}

class AddAddressDetailLoadingFailure extends ManageAddresesState {}

class UpdateAddressDetailLoading extends ManageAddresesState {}

class UpdateAddressDetailLoadingSuccesfull extends ManageAddresesState {}

class UpdateAddressDetailLoadingFailure extends ManageAddresesState {}

class DeleteAddressDetailLoading extends ManageAddresesState {}

class DeleteAddressDetailLoadingSuccesfull extends ManageAddresesState {}

class DeleteAddressDetailLoadingFailure extends ManageAddresesState {}

class DefaultAddressDetailLoading extends ManageAddresesState {}

class DefaultAddressDetailLoadingSuccesfull extends ManageAddresesState {}

class DefaultAddressDetailLoadingFailure extends ManageAddresesState {}

class ManageDialogueState extends ManageAddresesState {}

class LaunchAddNewAddressDialogueState extends ManageDialogueState {}

class LaunchEditAddressDialogueState extends ManageDialogueState {
  final Address address;

  LaunchEditAddressDialogueState(this.address);
}

class LaunchDeleteAddressDialogueState extends ManageDialogueState {
  final Address address;

  LaunchDeleteAddressDialogueState(this.address);
}
