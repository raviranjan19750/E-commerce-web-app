import 'package:flutter/material.dart';
import '../widgets.dart';

class AddAddressContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 300,
        height: 300,
        decoration: BoxDecoration(
          border: Border.all(
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        child: Card(
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
            child: Expanded(
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
        ),
      ),
    );
  }
}
