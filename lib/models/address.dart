import 'dart:html';

class Address {
  final String key;
  final String address;
  final String pincode;
  final Geolocation location;
  final bool isPrimary;
  final String name;
  final String phone;

  const Address({
    this.key,
    this.address,
    this.pincode,
    this.location,
    this.isPrimary,
    this.name,
    this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print(data.toString());
    var address = {
      'key': data['id'],
      'name': data['data']['name'],
      'address': data['data']['address'],
      'phone': data['data']['phone'],
      'isPrimary': data['data']['isPrimary'],
      'pincode': data['data']['pincode'],
      'location': data['data']['location'],
    };
    print(address.toString());
    return Address(
      key: data['id'],
      name: data['data']['name'],
      address: data['data']['address'],
      phone: data['data']['phone'],
      isPrimary: data['data']['isPrimary'],
      pincode: data['data']['pincode'],
      location: data['data']['location'],
    );
  }
}
