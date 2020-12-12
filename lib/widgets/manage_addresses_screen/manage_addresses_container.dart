import 'dart:developer';
import 'dart:html';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';

import '../../config/configs.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../data/data.dart';
import '../widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageAddressesContainer extends StatefulWidget {
  // Manage Address Container

  @override
  _ManageAddressesContainerState createState() =>
      _ManageAddressesContainerState();
}

class _ManageAddressesContainerState extends State<ManageAddressesContainer> {
  @override
  Widget build(BuildContext context) {
    Address address;

    print('Manage Address Container');
    return BlocConsumer<ManageAddressesBloc, ManageAddresesState>(
      listener: (context, state) {
        if (state is LaunchAddNewAddressDialogueState) {
          showDialog(
            context: context,
            builder: (BuildContext buildContext) {
              return NewAddressDialogBox(
                isAddAddress: true,
                onActionButton: (val) =>
                    {BlocProvider.of<ManageAddressesBloc>(context).add(val)},
              );
            },
          );
        } else if (state is LaunchEditAddressDialogueState) {
          showDialog(
              context: context,
              builder: (BuildContext buildContext) {
                return NewAddressDialogBox(
                  isEditAddress: true,
                  address: state.address,
                  onActionButton: (val) =>
                      {BlocProvider.of<ManageAddressesBloc>(context).add(val)},
                );
              });
        }
      },
      buildWhen: (prev, curr) {
        if (curr is ManageDialogueState) {
          return false;
        } else {
          return true;
        }
      },
      builder: (context, state) {
        if (state is AddressDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is AddressDetailLoadingSuccessful) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: Wrap(
                children: [
                  AddAddressContainer(),
                  ...state.addresses.map((address) {
                    print('Address:' + address.toString());
                    return AddressContainer(
                      address: address,
                    );
                  }),
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
