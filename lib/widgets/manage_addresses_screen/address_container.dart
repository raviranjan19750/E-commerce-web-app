import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/config/configs.dart';
import '../../bloc/manage_addresses/manage_addresses_bloc.dart';
import '../../models/models.dart';
import '../widgets.dart';

class AddressContainer extends StatelessWidget {
  final Address address;

  const AddressContainer({
    Key key,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.2,
        height: MediaQuery.of(context).size.height * 0.35,
        child: Card(
          elevation: 3.0,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(
              style: BorderStyle.solid,
              color: Colors.grey[400],
              width: 1.5,
            )),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                address.isPrimary == true
                    ? Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 8.0,
                            left: 12.0,
                            right: 12.0,
                          ),
                          child: Text(
                            Strings.defaultText,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                address.isPrimary
                    ? Divider(
                        color: Colors.grey[400],
                        thickness: 1.0,
                      )
                    : SizedBox.shrink(),
                Expanded(
                  child: Padding(
                    padding: address.isPrimary
                        ? EdgeInsets.only(
                            top: 0.0,
                            left: 16.0,
                            right: 16.0,
                            bottom: 16.0,
                          )
                        : EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 3.0,
                          ),
                          child: Text(
                            address.name,
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 3.0,
                            bottom: 3.0,
                          ),
                          child: Text(
                            address.address,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 3.0,
                          ),
                          child: Text(address.pincode),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            bottom: 3.0,
                          ),
                          child:
                              Text(Strings.phoneNumber + ': ' + address.phone),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    right: 16.0,
                    bottom: 12.0,
                  ),
                  child: Container(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            right: 8.0,
                          ),
                          child: InkWell(
                            child: Text(
                              Strings.edit,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              BlocProvider.of<ManageAddressesBloc>(context).add(
                                  LoadEditAddressDialogueEvent(
                                      address: address));
                            },
                          ),
                        ),
                        Container(
                          width: 1,
                          height: 16.0,
                          color: Colors.black,
                        ),

                        //delete address
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 8.0,
                            right: 8.0,
                          ),
                          child: InkWell(
                            child: Text(
                              Strings.delete,
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              BlocProvider.of<ManageAddressesBloc>(context)
                                  .add(DeleteAddress(
                                authID: "id1",
                                key: address.key,
                              ));
                            },
                          ),
                        ),
                        address.isPrimary
                            ? SizedBox.shrink()
                            : Container(
                                width: 1,
                                height: 16.0,
                                color: Colors.black,
                              ),
                        address.isPrimary
                            ? SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(
                                  left: 8.0,
                                  right: 8.0,
                                ),
                                child: InkWell(
                                  child: Text(
                                    Strings.setDefault,
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                  onTap: () {
                                    BlocProvider.of<ManageAddressesBloc>(
                                            context)
                                        .add(DefaultAddress(
                                      authID: "id1",
                                      key: address.key,
                                    ));
                                  },
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
