import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/widgets/widgets.dart';

class NewAddressForm extends StatefulWidget {
  @override
  _NewAddressFormState createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final _formKey = GlobalKey<FormState>();
  String name;
  String address;
  String phone;
  String pincode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = '';
    address = '';
    phone = '';
    pincode = '';
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

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
                onChanged: (String value) {
                  name = value;
                },
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
                onChanged: (String value) {
                  phone = value;
                },
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
                onChanged: (String value) {
                  address = value;
                },
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
                onChanged: (String value) {
                  pincode = value;
                },
              ),
            ),
            Container(
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    // Cancel Button
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        Strings.cancel,
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Palette.secondaryColor,
                    ),
                    // Add Button
                    child: InkWell(
                      onTap: () {
                        BlocProvider.of<ManageAddressesBloc>(context)
                            .add(AddAddress(
                          authID: "id1",
                          address: address,
                          name: name,
                          phone: phone,
                          pincode: pincode,
                        ));
                        // });
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        Strings.add,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
