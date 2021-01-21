import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NewAddressFormField extends StatelessWidget {
  final String hintText;
  final Function validator;
  final Function onSaved;
  final Function onChanged;
  final String initialValue;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;

  NewAddressFormField({
    this.initialValue,
    this.hintText,
    this.validator,
    this.maxLength,
    this.onSaved,
    this.onChanged,
    this.inputFormatters,
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
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        validator: validator,
        onSaved: onSaved,
        onChanged: onChanged,
      ),
    );
  }
}
