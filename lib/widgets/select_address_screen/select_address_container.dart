import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/config/configs.dart';
import '../../models/models.dart';
import '../widgets.dart';

class SelectAddressContainer extends StatefulWidget {
  @override
  _SelectAddressContainerState createState() => _SelectAddressContainerState();
}

class _SelectAddressContainerState extends State<SelectAddressContainer> {
  @override
  Widget build(BuildContext context) {
    int isSelectedCount = 0;
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
            padding: const EdgeInsets.only(
              top: 16.0,
              right: 16.0,
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

                // Is any Addresss Selected
                // ...state.addresses.map((address) {
                //   if (address.isSelected) {
                //     isSelectedCount = isSelectedCount + 1;
                //   }
                // }),
                // Selected address Primary Address
                ...state.addresses.map((address) {
                  if (isSelectedCount > 0 && address.isSelected) {
                    return AddressContainer(
                      address: address,
                    );
                  } else if (isSelectedCount == 0 && address.isPrimary) {
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
                          if (!address.isSelected) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  address.isSelected = true;
                                });
                              },
                              child: AddressContainer(
                                address: address,
                              ),
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
        return Container();
      },
    );
  }
}
