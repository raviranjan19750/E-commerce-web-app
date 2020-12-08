part of 'manage_addresses_bloc.dart';

abstract class ManageAddressesEvent {}

class InitializeLoadingAddresses extends ManageAddressesEvent {}

class LoadAllAddresses extends ManageAddressesEvent {
  final String authID;

  LoadAllAddresses(
    this.authID,
  );
}
