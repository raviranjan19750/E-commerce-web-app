import 'dart:convert';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class AddresssRepository {
  // final CollectionReference addressCollectionReference =
  //     FirebaseFirestore.instance.collection('addresses');

  Future<List<Address>> getAddressDetails(String authID) async {
    //   try {
    //     print('Firebase query');
    //     var addressDetailsData = await addressCollectionReference
    //         .where('authID', isEqualTo: authID)
    //         .orderBy('isPrimary', descending: true)
    //         .get();
    //     print(addressDetailsData.toString());

    //     if (addressDetailsData.docs.isNotEmpty) {
    //       return addressDetailsData.docs.map<Address>((snapshot) {
    //         print(snapshot.data().toString());
    //         return Address.fromMap(snapshot.data());
    //       }).toList();
    //     } else {}
    //   } catch (e) {
    //     print(e.toString());
    //     throw Exception(e);
    //   }
    // }
    try {
      print('Sending Http Request');
      final response = await http.get(
          'https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageAddress/list/${authID}');
      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
        print(jsonDecode(response.body).toString());
        return (jsonDecode(response.body) as List)
            .map((i) => Address.fromJson(i))
            .toList();
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
