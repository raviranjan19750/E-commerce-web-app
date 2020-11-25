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
        child: ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            return AddressContainer(
              address: addresses[index],
            );
          },
        ),
      ),
    );
  }
}
