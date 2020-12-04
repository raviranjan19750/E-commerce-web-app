import 'dart:html';

class Address {
  final String addressLine;
  final String pincode;
  final Geolocation location;
  final bool isPrimary;
  final String name;
  final String phone;

  const Address({
    this.addressLine,
    this.pincode,
    this.location,
    this.isPrimary,
    this.name,
    this.phone,
  });
}
