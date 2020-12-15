import 'package:flutter/material.dart';

class NewAddressFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final String initialValue;

  NewAddressFormField({
    this.initialValue,
    this.hintText,
    this.validator,
    this.onSaved,
    this.onChanged,
  });

  // Form Field for new Addresses

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: hintText,
          //border: InputBorder.none,
          labelStyle: TextStyle(color: Colors.blue),
          // focusedBorder: InputBorder.none,
          // enabledBorder: InputBorder.none,
          // errorBorder: InputBorder.none,
          // disabledBorder: InputBorder.none,
        ),
        cursorColor: Colors.black,
        initialValue: initialValue,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}
