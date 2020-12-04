import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/data/data.dart';
import '../../models/models.dart';
import '../widgets.dart';

class SelectAddressContainer extends StatelessWidget {
  // Get Addresses based on Auth ID
  final List<Address> addresses = address;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
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
            SizedBox(
              height: 10,
            ),
            // Primary Address
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.2,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(address[0].name),
                      Text(address[0].addressLine),
                      Text(address[0].pincode),
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
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              Strings.changeAddress,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                  ),
                  itemCount: addresses.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (!addresses[index].isPrimary) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(address[index].name),
                                Text(address[index].addressLine),
                                Text(address[index].pincode),
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
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                    if (index == addresses.length + 1) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2.0,
                              style: BorderStyle.solid,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              // Dialog Box
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return NewAddressDialogBox();
                                },
                              );
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
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
