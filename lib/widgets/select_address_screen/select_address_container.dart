import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/select_address/select_address_bloc.dart';
import 'package:living_desire/config/configs.dart';
import '../../models/models.dart';
import '../widgets.dart';

class SelectAddressContainer extends StatelessWidget {
  String authID;

  SelectAddressContainer({
    Key key,
    this.authID,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageAddressesBloc, ManageAddresesState>(
      listener: (context, state) {
        if (state is LaunchAddNewAddressDialogueState) {
          showDialog(
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
      // ignore: missing_return
      builder: (context, state) {
        if (state is AddressDetailLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is AddressDetailLoadingSuccessful) {
          return Padding(
            padding: const EdgeInsets.only(top: 16.0, right: 16.0, left: 32),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  child: Text(
                    Strings.deliveringTo,
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectAddressGrid(
                    addresses: state.addresses,
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

class SelectAddressGrid extends StatefulWidget {
  final List<Address> addresses;

  Address selectedAddress;

  SelectAddressGrid({
    Key key,
    this.addresses,
  }) : super(key: key);
  @override
  _SelectAddressGridState createState() => _SelectAddressGridState();
}

class _SelectAddressGridState extends State<SelectAddressGrid> {
  @override
  void initState() {
    super.initState();

    if (widget.addresses.length == 0) {
      BlocProvider.of<SelectAddressBloc>(context).add(LoadAddress(null));
    } else {
      widget.selectedAddress = widget.addresses[0];
      // BLOC provider to select Address bloc pass the value of selected address
      BlocProvider.of<SelectAddressBloc>(context)
          .add(LoadAddress(widget.selectedAddress));
    }
  }

  @override
  Widget build(BuildContext context) {
    // print('Select Addresses' + widget.addresses.length.toString());
    return Wrap(
      children: [
        ...widget.addresses.map((address) {
          return InkWell(
            onTap: () {
              setState(() {
                widget.selectedAddress = address;
              });
              // BLOC provider to select Address bloc pass the value of selected address
              BlocProvider.of<SelectAddressBloc>(context)
                  .add(LoadAddress(widget.selectedAddress));
            },
            child: AddressContainer(
              address: address,
              selectedAddress: widget.selectedAddress,
            ),
          );
        }),
        AddAddressContainer(),
      ],
    );
  }
}
