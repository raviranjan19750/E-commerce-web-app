import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class WishlistRepository {
  // Get Wishlist Details
  Future<List<Wishlist>> getWishlistDetails(String authID) async {
    try {
      print('Sending Wishlist Http Request');
      final response =
          await http.get(FunctionConfig.host + 'manageWishlist/${authID}');
      if (response.statusCode == 200) {
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

  //Add a whishlist item

  Future<void> addWishlistDetails(
    String authID,
    String productID,
    String variantID,
  ) async {
    var params = {
      "productID": productID,
      "variantID": variantID,
    };
    try {
      final response = await http.post(
        FunctionConfig.host + 'manageWishlist/${authID}',
        body: params,
      );
      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  // Delete a wishlist

  Future<void> deleteWishlistDetails(
    String key,
  ) async {
    try {
      final response = await http.delete(
        FunctionConfig.host + 'manageWishlist/${key}',
      );
      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }
}
