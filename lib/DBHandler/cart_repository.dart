import 'dart:convert';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

import '../logger.dart';

class CartRepository {
  var LOG = LogBuilder.getLogger();

  List<Cart> _cart = List.empty();

  List<Cart> get cart => _cart;

  int get totalCartItem {
    int count = 0;
    for (var c in _cart) {
      count += c.quantity;
    }
    return count;
  }

  double get cartDiscountedTotal {
    double total = 0;
    for (var c in _cart) {
      total += (c.quantity * c.discountPrice);
    }
    return total;
  }

  double get cartRetailTotal {
    double total = 0;
    for (var c in _cart) {
      total += (c.quantity * c.sellingPrice);
    }
    return total;
  }

  Future<List<Cart>> getCartDetails(String authID) async {
    LOG.v('Requesting all cart details for ${authID}');
    try {
      final response =
          await CloudFunctionConfig.get('manageCart/normal/${authID}');

      if (response.statusCode == 200) {
        //Map<String, dynamic> map = json.decode(response.body);
        LOG.i('Http Request sucessfull ${response.body}');
        _cart = (jsonDecode(response.body) as List<dynamic>)
            .map((i) => Cart.fromJson(i))
            .toList();
        return _cart;
      } else {
        LOG.i(response.statusCode);
      }
    } catch (e) {
      LOG.e(e);
      throw Exception(e);
    }
  }

  // Add Cart Details
  Future<void> addCartDetails(
    String authID,
    String productID,
    String variantID,
    int quantity,
  ) async {
    try {
      var data = {
        "authID": authID,
        "productID": productID,
        "variantID": variantID,
        "quantity": quantity
      };
      final response =
          await CloudFunctionConfig.post('manageCart/normal/${authID}', data);
      if (response.statusCode == 200) {
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  //Change Quantity Cart Details
  Future<void> changeQuantityCartDetails(
    String key,
    var quantity,
  ) async {
    try {
      var data = {
        "quantity": quantity,
      };

      print(jsonEncode(data));

      final request =
          await CloudFunctionConfig.put('manageCart/normal/' + key, data);

      if (request.statusCode == 200) {
        // Updating the item quamtity in our local state
        for (var c in _cart) {
          if (c.key == key) {
            c.quantity = quantity;
            break;
          }
        }

        _cart.removeWhere((element) => element.quantity == 0);
        LOG.i(_cart.length);
      } else {
        LOG.e(request.body);
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  //Delete Cart Details
  Future<void> deleteCartDetails({
    String key,
    String authID,
    String productID,
  }) async {
    try {
      final request = await CloudFunctionConfig.delete(
          'manageCart/normal/${authID}/${productID}/${key}');

      if (request.statusCode == 200) {
        LOG.i(_cart.length);

        LOG.i('Removing Key ${key}');
        _cart.removeWhere((element) => element.key.compareTo(key) == 0);
        LOG.i(_cart.length);
      } else {
        LOG.e(request.body);
      }
    } catch (e) {
      LOG.e(e.toString());
      throw Exception(e);
    }
  }
}
