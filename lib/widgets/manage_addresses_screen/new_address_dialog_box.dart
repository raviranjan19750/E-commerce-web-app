import 'package:flutter/material.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/widgets/widgets.dart';
import '../../config/configs.dart';

class NewAddressDialogBox extends StatelessWidget {
  final Function onActionButton;
  final bool isAddAddress;
  final bool isEditAddress;
  final Address address;
  String authID;

  NewAddressDialogBox({
    Key key,
    this.onActionButton,
    this.authID,
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ADD NEW ADDRESS TEXT

            isAddAddress
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      Strings.addNewAddress,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox.shrink(),

            // Edit Address text

            isEditAddress
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      Strings.updateAddress,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            // TODO:Form
            NewAddressForm(
              authID: authID,
              address: address,
              isAddAddress: isAddAddress,
              isEditAddress: isEditAddress,
              onActionAddress: onActionButton,
            ),
            // Submit Button
          ],
        ),
      ),
    );
  }
}
