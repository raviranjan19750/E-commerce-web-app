import 'package:flutter/material.dart';
import './models.dart';

class UserDetails {
  String uid;
  String phone;
  bool isSignedIn = false;
  UserDetails({@required this.uid, this.phone});
}
