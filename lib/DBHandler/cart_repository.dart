import 'dart:convert';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  Future<List<Cart>> getCartDetails(String authID) async {
    try {
      print('Sending Cart Http Request');
      final response = await http.get(
          'https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageCart/${authID}');
      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
        print(jsonDecode(response.body).toString());
        return (jsonDecode(response.body) as List)
            .map((i) => Cart.fromJson(i))
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
