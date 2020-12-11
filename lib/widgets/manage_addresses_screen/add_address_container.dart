import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import '../widgets.dart';

class AddAddressContainer extends StatelessWidget {

  void addNewAddress(context, newAddress) {
    BlocProvider.of<ManageAddressesBloc>(context)
        .add(newAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Card(
          child: InkWell(
            onTap: () {
              BlocProvider.of<ManageAddressesBloc>(context)
                  .add(LoadAddAddressDialogueEvent());
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
      ),
    );
  }
}
