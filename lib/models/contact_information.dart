import 'dart:html';

import 'package:flutter/material.dart';

class ContactInformation {
  final String pincode;
  final String addressLine;
  final Geolocation location;
  final String name;
  final String phone;
  final String alternatePhone;

  const ContactInformation({
    this.pincode,
    this.addressLine,
    this.location,
    this.name,
    this.phone,
    this.alternatePhone,
  });
}
