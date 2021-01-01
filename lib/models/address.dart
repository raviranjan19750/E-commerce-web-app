import 'dart:html';

class Address {
  String key;
  String address;
  String pincode;
  Geolocation location;
  bool isPrimary;
  String name;
  String phone;
  bool isSelected;

  Address({
    this.key,
    this.address,
    this.pincode,
    this.location,
    this.isPrimary,
    this.name,
    this.isSelected = false,
    this.phone,
  });

  factory Address.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    // print(data.toString());
    // var address = {
    //   'key': data['id'],
    //   'name': data['data']['name'],
    //   'address': data['data']['address'],
    //   'phone': data['data']['phone'],
    //   'isPrimary': data['data']['isPrimary'],
    //   'pincode': data['data']['pincode'],
    //   'location': data['data']['location'],
    // };
    // print(address.toString());
    return Address(
      key: data['id'],
      name: data['data']['name'],
      address: data['data']['address'],
      phone: data['data']['phone'],
      isPrimary: data['data']['isPrimary'],
      pincode: data['data']['pincode'],
      location: data['data']['location'],
      isSelected: false,
    );
  }
}
