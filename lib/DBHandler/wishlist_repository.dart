import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class WishlistRepository {
  // Get Wishlist Details
  var LOG = Logger();
  Future<List<Wishlist>> getWishlistDetails(String authID) async {
    try {
      final response = await CloudFunctionConfig.get('manageWishlist/$authID');

      if (response.statusCode == 200) {
        return (jsonDecode(response.body) as List)
            .map((i) => Wishlist.fromJson(i))
            .toList();
      } else {
        LOG.e('Http Request Failed');
      }
    } catch (e) {
      LOG.e(e.toString());
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
      final response =
          await CloudFunctionConfig.post('manageWishlist/${authID}', params);

      if (response.statusCode == 200) {
        LOG.i('Http Get request sucessfull');
      } else {
        LOG.e('Http Request Failed');
      }
    } catch (e) {
      LOG.e(e.toString());
      throw Exception(e);
    }
  }

  // Delete a wishlist

  Future<void> deleteWishlistDetails(
      String key, String productID, String authID) async {
    try {
      // var params = {
      //   "productID":productID,
      // };
      final response = await CloudFunctionConfig.delete(
          'manageWishlist/${authID}/${productID}/${key}');

      if (response.statusCode == 200) {
        LOG.i('Http Get request sucessfull');
      } else {
        LOG.e(response.body);
      }
    } catch (e) {
      LOG.e(e.toString());
      throw Exception(e);
    }
  }
}
