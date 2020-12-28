import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';
import '../widgets.dart';

class SelectAddressContainer extends StatelessWidget {
  // Get Addresses based on Auth ID
  final List<Address> addresses = address;
  @override
  Widget build(BuildContext context) {
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
      // ignore: missing_return
      builder: (context, state) {
        if (state is AddressDetailLoading) {
          return CircularProgressIndicator();
        } else if (state is AddressDetailLoadingSuccessful) {
          return Padding(
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
              left: 32
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Strings.deliveringTo,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                // Primary Address

                ...state.addresses.map((address) {
                  if (address.isPrimary) {
                    return AddressContainer(
                      address: address,
                    );
                  }
                  return SizedBox.shrink();
                }),

                Text(
                  Strings.changeAddress,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 16.0,
                    left: 16.0,
                    right: 16.0,
                    bottom: 16.0,
                  ),
                  child: Container(
                    child: Wrap(
                      children: [
                        ...state.addresses.map((address) {
                          if (!address.isPrimary) {
                            return AddressContainer(
                              address: address,
                            );
                          } else {
                            return SizedBox.shrink();
                          }
                        }),
                        AddAddressContainer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
