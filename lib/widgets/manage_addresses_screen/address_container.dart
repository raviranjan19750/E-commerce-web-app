import 'package:flutter/material.dart';
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
              address.isPrimary
                  ? Container(
                      child: Text('Default:'),
                    )
                  : SizedBox.shrink(),
              address.isPrimary ? Divider() : SizedBox.shrink(),
              Text(address.name),
              Text(address.addressLine),
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
                      onPressed: () {},
                    ),
                    address.isPrimary ? SizedBox.shrink() : const Divider(),
                    address.isPrimary
                        ? SizedBox.shrink()
                        : FlatButton(
                            child: Text('Set as Default'),
                            onPressed: () {},
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
