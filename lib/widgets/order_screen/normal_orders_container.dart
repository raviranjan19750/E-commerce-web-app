import 'package:flutter/material.dart';

class NormalOrdersContainer extends StatelessWidget {
  // Normal Order Container
  @override
  Widget build(BuildContext context) {
    //final List<Order> orders;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        child: Column(
          children: [
            Divider(),
            Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
              ),
              //child: ListView.builder(itemCount: ,),
            ),
          ],
        ),
      ),
    );
  }
}
