// To parse this JSON data, do
//
//     final userDetail = userDetailFromJson(jsonString);

import 'dart:convert';

UserDetail userDetailFromJson(String str) =>
    UserDetail.fromJson(json.decode(str));

String userDetailToJson(UserDetail data) => json.encode(data.toJson());

class UserDetail {
  UserDetail({
    this.name,
    this.email,
    this.phone,
  });

  String name;
  String email;
  String phone;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "phone": phone,
      };
}
