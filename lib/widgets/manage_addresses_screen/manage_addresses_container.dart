import 'dart:developer';
import 'dart:html';
import '../../config/configs.dart';
import 'package:flutter/material.dart';
import '../../models/models.dart';
import '../../data/data.dart';
import '../widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManageAddressesContainer extends StatefulWidget {
  // Manage Address Container

  @override
  _ManageAddressesContainerState createState() =>
      _ManageAddressesContainerState();
}

class _ManageAddressesContainerState extends State<ManageAddressesContainer> {
  @override
  Widget build(BuildContext context) {
    List<Address> addresses = address;

    // FirebaseFirestore firestore = FirebaseFirestore.instance;
    // addresses = [];
    // //firestore query
    // print("firestore query");
    // firestore
    //     .collection("addresses")
    //     .where("authID", isEqualTo: "sampleAuthID1")
    //     .get()
    //     .then((value) {
    //   print(value.toString());
    //   for (int i = 0; i < value.docs.length; i++) {
    //     print("firestore query address result : " +
    //         value.docs[i].data().toString());
    //     addresses.add(Address(
    //       addressLine: value.docs[i].data()["address"],
    //       isPrimary: value.docs[i].data()["isPrimary"],
    //       name: value.docs[i].data()["name"],
    //       pincode: value.docs[i].data()["pincode"],
    //       phone: value.docs[i].data()["phone"] ?? '',
    //     ));
    //     print(addresses[i].name.toString());
    //   }
    // }).catchError((error) {
    //   print('Firestore Error' + error);
    // });

    print('Manage Address Container');
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        child: Wrap(
          children: [
            AddAddressContainer(),
            ...addresses.map((e) {
              print('Address:' + e.toString());
              return AddressContainer(
                address: e,
              );
            }),
          ],
        ),
      ),
    );
  }
}