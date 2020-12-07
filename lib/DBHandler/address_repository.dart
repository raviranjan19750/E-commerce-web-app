import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:living_desire/models/models.dart';

class AddresssRepository {
  final CollectionReference addressCollectionReference =
      FirebaseFirestore.instance.collection('addresses');

  Future<List<Address>> getAddressDetails({String authID}) async {
    try {
      print('Firebase query');
      var addressDetailsData = await addressCollectionReference
          .where('authID', isEqualTo: authID)
          .get();
      print(addressDetailsData.toString());

      if (addressDetailsData.docs.isNotEmpty) {
        return addressDetailsData.docs.map<Address>((snapshot) {
          print(snapshot.data().toString());
          return Address.fromMap(snapshot.data());
        }).toList();
      } else {
        return null;
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
