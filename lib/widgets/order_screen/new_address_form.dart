import 'package:flutter/material.dart';
import 'package:living_desire/widgets/widgets.dart';

class NewAddressForm extends StatefulWidget {
  @override
  _NewAddressFormState createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            child: NewAddressFormField(
              hintText: 'Name',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter your Name';
                }
                return null;
              },
              onSaved: (String value) {},
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            child: NewAddressFormField(
              hintText: 'Mobile',
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Enter your Mobile Number';
                }
                return null;
              },
              onSaved: (String value) {},
            ),
          )
        ],
      ),
    );
  }
}
