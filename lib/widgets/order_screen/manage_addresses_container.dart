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
    print('Manage Address Container');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        child: Wrap(
          children: [
            AddAddressContainer(),
            ...addresses.map(
              (e) => AddressContainer(
                address: e,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
