part of 'manage_addresses_bloc.dart';

abstract class ManageAddressesEvent {}

class InitializeLoadingAddresses extends ManageAddressesEvent {}

class LoadAllAddresses extends ManageAddressesEvent {
  final String authID;

  LoadAllAddresses(
    this.authID,
  );
}

class AddAddress extends ManageAddressesEvent {
  final String authID;
  final String name;
  final String phone;
  final String address;
  final String pincode;

  AddAddress({
    this.authID,
    this.name,
    this.phone,
    this.address,
    this.pincode,
  });
}

class UpdateAddress extends ManageAddressesEvent {
  final String key;
  final String name;
  final String phone;
  final String address;
  final String pincode;

  UpdateAddress({
    this.key,
    this.name,
    this.phone,
    this.address,
    this.pincode,
  });
}

class DeleteAddress extends ManageAddressesEvent {
  final String key;
  final String authID;

  DeleteAddress({
    this.key,
    this.authID,
  });
}

class DefaultAddress extends ManageAddressesEvent {
  final String key;
  final String authID;

  DefaultAddress({
    this.key,
    this.authID,
  });
}
