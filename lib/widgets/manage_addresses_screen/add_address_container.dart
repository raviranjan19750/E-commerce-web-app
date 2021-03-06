import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/manage_addresses/manage_addresses_bloc.dart';
import 'package:living_desire/config/configs.dart';
import '../widgets.dart';

class AddAddressContainer extends StatelessWidget {
  void addNewAddress(context, newAddress) {
    BlocProvider.of<ManageAddressesBloc>(context).add(newAddress);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Card(
          elevation: 3.0,
          borderOnForeground: true,
          child: DottedBorder(
            color: Colors.grey,
            strokeWidth: 2,
            borderType: BorderType.RRect,
            dashPattern: [10, 3],
            child: InkWell(
              onTap: () {
                BlocProvider.of<ManageAddressesBloc>(context)
                    .add(LoadAddAddressDialogueEvent());
              },
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.grey,
                      size: 50,
                    ),
                    Text(
                      Strings.addAddress,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey[700],
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
