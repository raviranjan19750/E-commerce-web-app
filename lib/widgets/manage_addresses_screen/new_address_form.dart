import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/widgets.dart';
import 'package:logger/logger.dart';

class NewAddressForm extends StatefulWidget {
  final Function onActionAddress;
  final bool isAddAddress;
  final bool isEditAddress;
  final Address address;
  final authID;

  const NewAddressForm({
    Key key,
    this.address,
    this.authID,
    this.onActionAddress,
    this.isAddAddress = false,
    this.isEditAddress = false,
  }) : super(key: key);

  @override
  _NewAddressFormState createState() => _NewAddressFormState();
}

class _NewAddressFormState extends State<NewAddressForm> {
  final _formKey = GlobalKey<FormState>();

  String name;
  String address;
  String phone;
  String pincode;

  // Logger
  var LOG = Logger();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.isAddAddress ? '' : widget.address.name;
    address = widget.isAddAddress ? '' : widget.address.address;
    phone = widget.isAddAddress ? '' : widget.address.phone;
    pincode = widget.isAddAddress ? '' : widget.address.pincode;
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 12.0,
                  right: 12.0,
                ),
                child: Column(
                  children: [
// Name Field
                    Container(
                      alignment: Alignment.topCenter,
                      child: NewAddressFormField(
                        initialValue:
                            widget.isAddAddress ? '' : widget.address.name,
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
                        initialValue:
                            widget.isAddAddress ? '' : widget.address.phone,
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
                        initialValue:
                            widget.isAddAddress ? '' : widget.address.address,
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
                        initialValue:
                            widget.isAddAddress ? '' : widget.address.pincode,
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
                  ],
                ),
              ),
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cancel Button
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Material(
                        elevation: 10.0,
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.08,
                          color: Colors.white,
                          child: Center(
                            child: Text(
                              Strings.cancel,
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  widget.isAddAddress
                      ?
                      // Add Button
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              print('Adding new Address');
                              widget.onActionAddress(AddAddress(
                                authID: widget.authID,
                                address: address,
                                name: name,
                                phone: phone,
                                pincode: pincode,
                              ));
                              Navigator.of(context).pop();
                            },
                            child: Material(
                              elevation: 10.0,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    Strings.add,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  widget.isEditAddress
                      ?
                      // Add Button
                      Expanded(
                          child: InkWell(
                            onTap: () {
                              var value = UpdateAddress(
                                address: address,
                                authID: widget.authID,
                                name: name,
                                phone: phone,
                                pincode: pincode,
                                key: widget.address.key,
                              );
                              LOG.i('Update Address Event ${value}');
                              widget.onActionAddress(value);

                              Navigator.of(context).pop();
                            },
                            child: Material(
                              elevation: 10.0,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.08,
                                color: Colors.black,
                                child: Center(
                                  child: Text(
                                    Strings.update,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
