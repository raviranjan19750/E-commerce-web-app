import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/manage_addresses/manage_addresses_bloc.dart';
import '../../models/models.dart';

class AddressContainer extends StatelessWidget {
  final Address address;

  const AddressContainer({
    Key key,
    this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Address Container');
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        width: 300,
        height: 300,
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              address.isPrimary == true
                  ? Container(
                      child: Text('Default:'),
                    )
                  : SizedBox.shrink(),
              address.isPrimary ? Divider() : SizedBox.shrink(),
              Text(address.name),
              Text(address.address),
              Text(address.pincode),
              Container(
                child: Row(
                  children: [
                    FlatButton(
                      child: Text('Edit'),
                      onPressed: () {},
                    ),
                    const Divider(
                      thickness: 3,
                    ),
                    FlatButton(
                      child: Text('Delete'),
                      onPressed: () {
                        BlocProvider.of<ManageAddressesBloc>(context)
                            .add(DeleteAddress(
                          authID: "id1",
                          key: address.key,
                        ));
                      },
                    ),
                    address.isPrimary ? SizedBox.shrink() : const Divider(),
                    address.isPrimary
                        ? SizedBox.shrink()
                        : FlatButton(
                            child: Text('Set as Default'),
                            onPressed: () {
                              BlocProvider.of<ManageAddressesBloc>(context)
                                  .add(DefaultAddress(
                                authID: "id1",
                                key: address.key,
                              ));
                            },
                          ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
