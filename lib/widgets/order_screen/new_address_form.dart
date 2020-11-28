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
    // Address Form
    return Form(
      key: _formKey,
      child: Expanded(
        child: Column(
          children: [
            // Name Field
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
            // mobile Field
            // TODO: Set Keyboard type to number and validate mobile number 10 digits
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
            ),
            // Address Field
            // TODO: Make Address Field multiline
            Container(
              alignment: Alignment.topCenter,
              child: NewAddressFormField(
                hintText: 'Address',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter your Address';
                  }
                  return null;
                },
                onSaved: (String value) {},
              ),
            ),
            // Pincode Field
            // TODO: Set keyboard type to number and validate pincode 6 digits
            Container(
              alignment: Alignment.topCenter,
              child: NewAddressFormField(
                hintText: 'Pincode',
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Enter valid Pincode';
                  }
                  return null;
                },
                onSaved: (String value) {},
              ),
            )
          ],
        ),
      ),
    );
  }
}
