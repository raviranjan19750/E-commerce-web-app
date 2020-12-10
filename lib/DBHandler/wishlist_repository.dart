import 'package:living_desire/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WishlistRepository {
  Future<List<Wishlist>> getWishlistDetails(String authID) async {
    try {
      print('Sending Wishlist Http Request');
      final response = await http.get(
          'https://us-central1-livingdesire-2107-dev.cloudfunctions.net/manageWishlist/${authID}');
      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
        print(jsonDecode(response.body).toString());
        return (jsonDecode(response.body) as List)
            .map((i) => Wishlist.fromJson(i))
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
