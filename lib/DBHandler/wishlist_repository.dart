import 'dart:math';

import 'package:living_desire/DBHandler/local_storage.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/localwishlist.dart';
import 'package:living_desire/models/models.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:hive/hive.dart';

class WishlistRepository {
  // Get Wishlist Details
  var LOG = Logger();
  static const AUTO_ID_ALPHABET =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static const AUTO_ID_LENGTH = 20;
  String _getAutoId() {
    final buffer = StringBuffer();
    final random = Random.secure();

    final maxRandom = AUTO_ID_ALPHABET.length;

    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      buffer.write(AUTO_ID_ALPHABET[random.nextInt(maxRandom)]);
    }
    return buffer.toString();
  }

  Future<List<Wishlist>> getWishlistDetails(String authID) async {
    try {
      if (authID != null) {
        final response =
            await CloudFunctionConfig.get('manageWishlist/$authID');

        if (response.statusCode == 200) {
          return (jsonDecode(response.body) as List)
              .map((i) => Wishlist.fromJson(i))
              .toList();
        } else {
          LOG.e('Http Request Failed');
        }
      } else {
        final _wishlist = Hive.box<WishlistLocal>('wishlist_items');

        Map<dynamic, WishlistLocal> wsh = _wishlist.toMap();
        var data = [];
        var keys = [];
        wsh.forEach((key, value) {
          var keyData = {
            "key": key,
            "variantID": value.variantID,
          };
          keys.add(keyData);
          var wishlistData = {
            "productID": value.productID,
            "variantID": value.variantID
          };
          data.add(wishlistData);
        });
        final response = await CloudFunctionConfig.post(
            'manageAnonymousUser/get-wishlist', data);
        if (response.statusCode == 200) {
          List<Wishlist> wishlist =
              (jsonDecode(response.body) as List).map((e) {
            for (int i = 0; i < keys.length; i++) {
              if (e['variantID'] == (keys[i])["variantID"]) {
                return Wishlist.fromJsonMap(e, (keys[i])["key"]);
              }
            }
          }).toList();
          return wishlist;
        }
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
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
      if (authID != null) {
        final response =
            await CloudFunctionConfig.post('manageWishlist/${authID}', params);

        if (response.statusCode == 200) {
          LOG.i('Http Get request sucessfull');
        } else {
          LOG.e('Http Request Failed');
        }
      } else {
        Wishlist itm = new Wishlist(
          key: _getAutoId(),
          productID: productID,
          variantID: variantID,
        );
        WishlistLocalStorage(itm).saveToLocalStorage();
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  // Delete a wishlist

  Future<void> deleteWishlistDetails(
      String key, String productID, String authID) async {
    try {
      if (authID != null) {
        final response = await CloudFunctionConfig.delete(
            'manageWishlist/${authID}/${productID}/${key}');

        if (response.statusCode == 200) {
          LOG.i('Http Get request sucessfull');
        } else {
          LOG.e(response.body);
        }
      } else {
        Wishlist itm = new Wishlist(
          key: key,
          productID: productID,
        );
        WishlistLocalStorage(itm).deleteFromLocalStorage(itm.key);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }
}
