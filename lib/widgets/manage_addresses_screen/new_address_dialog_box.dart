import 'package:flutter/material.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../../config/configs.dart';

class NewAddressDialogBox extends StatelessWidget {
  final Function onActionButton;
  final bool isAddAddress;
  final bool isEditAddress;
  final Address address;

  const NewAddressDialogBox({
    Key key,
    this.onActionButton,
    this.address,
    this.isAddAddress = false,
    this.isEditAddress = false,
  }) : super(key: key);

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

                isAddAddress ? Text(Strings.addNewAddress) : SizedBox.shrink(),

                // Edit Address text

                isEditAddress ? Text(Strings.updateAddress) : SizedBox.shrink(),
                // TODO:Form
                NewAddressForm(
                  address: address,
                  isAddAddress: isAddAddress,
                  isEditAddress: isEditAddress,
                  onActionAddress: onActionButton,
                ),
                // Submit Button
              ],
            ),
          ),
        ),
      ),
    );
  }
}
