import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:living_desire/models/models.dart';

class AddresssRepository {
  final CollectionReference addressCollectionReference =
      FirebaseFirestore.instance.collection('addresses');
  
  Future<List<Address>> getAddressDetails({String authID}) async{
    try{
      var addressDetailsData=await addressCollectionReference.where('authID', isEqualTo: authID).get();
      
    }
    catch
  }
}
