import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../../config/configs.dart';

class NewAddressDialogBox extends StatefulWidget {
  @override
  _NewAddressDialogBoxState createState() => _NewAddressDialogBoxState();
}

class _NewAddressDialogBoxState extends State<NewAddressDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.35,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ADD NEW ADDRESS TEXT
                Text(Strings.addNewAddress),
                // TODO:Form
                NewAddressForm(),
                // Submit Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
