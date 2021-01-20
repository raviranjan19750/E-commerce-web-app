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

class ManageAddressesContainer extends StatelessWidget {
  final String authID;

  const ManageAddressesContainer({
    Key key,
    this.authID,
  }) : super(key: key);
  // Manage Address Container

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageAddressesBloc, ManageAddresesState>(
      listener: (context, state) {
        if (state is LaunchAddNewAddressDialogueState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext buildContext) {
              return NewAddressDialogBox(
                authID: authID,
                isAddAddress: true,
                onActionButton: (val) =>
                    {BlocProvider.of<ManageAddressesBloc>(context).add(val)},
              );
            },
          );
        } else if (state is LaunchEditAddressDialogueState) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (BuildContext buildContext) {
                return NewAddressDialogBox(
                  authID: authID,
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
            padding: const EdgeInsets.only(
              top: 40.0,
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Container(
              child: Wrap(
                children: [
                  AddAddressContainer(),
                  ...state.addresses.map((address) {
                    return AddressContainer(
                      authID: authID,
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

class DeleteAddressContainer extends StatelessWidget {
  final Address address;
  final Function onAction;
  String authID;

  DeleteAddressContainer({
    Key key,
    this.onAction,
    this.address,
    this.authID,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                Strings.areYouSure,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      onAction(DeleteAddress(
                        authID: authID,
                        key: address.key,
                      ));
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.yes,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      Strings.no,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
