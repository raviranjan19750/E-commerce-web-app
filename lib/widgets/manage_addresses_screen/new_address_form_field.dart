import 'package:flutter/material.dart';

class NewAddressFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;

  NewAddressFormField({
    this.hintText,
    this.validator,
    this.onSaved,
  });

  // Form Field for new Addresses

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          contentPadding: EdgeInsets.all(15.0),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
        ),
        validator: validator,
        onSaved: onSaved,
      ),
    );
  }
}
