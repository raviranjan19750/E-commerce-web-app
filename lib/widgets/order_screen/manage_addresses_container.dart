import 'dart:html';
import '../../config/configs.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../data/data.dart';
import '../widgets.dart';

class ManageAddressesContainer extends StatelessWidget {
  // Manage Address Container

  final List<Address> addresses = address;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        child: GridView.builder(
          itemCount: addresses.length + 1,
          itemBuilder: (context, index) {
            if (index == 0) {
              // Add Address Container
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 2.0,
                      style: BorderStyle.solid,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      // Dialog Box
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return NewAddressDialogBox();
                        },
                      );
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add),
                        Text('Add Address'),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              // Already Added Address Container
              return AddressContainer(
                address: addresses[index - 1],
              );
            }
          },
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        ),
      ),
    );
  }
}
