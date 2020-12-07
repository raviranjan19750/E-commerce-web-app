import 'dart:html';

class Address {
  final String address;
  final String pincode;
  final Geolocation location;
  final bool isPrimary;
  final String name;
  final String phone;

  const Address({
    this.address,
    this.pincode,
    this.location,
    this.isPrimary,
    this.name,
    this.phone,
  });

  static Address fromMap(Map<String, dynamic> data) {
    if (data == null) return null;

    return Address(
      name: data['name'],
      address: data['address'],
      phone: data['phone'],
      isPrimary: data['isPrimary'],
      pincode: data['pincode'],
      location: data['location'],
    );
  }
}
