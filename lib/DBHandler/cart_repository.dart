import 'dart:convert';
import 'package:living_desire/config/function_config.dart';
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
    try {
      final response =
          await http.get(FunctionConfig.host + 'manageCart/normal/${authID}');
      if (response.statusCode == 200) {
        //Map<String, dynamic> map = json.decode(response.body);

        _cart = ((jsonDecode(response.body) as List<dynamic>)
            .map((i) => Cart.fromJson(i))).toList();
        return _cart;
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print(e.toString());
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
      final response = await http.post(
          FunctionConfig.host + 'manageCart/normal/${authID}',
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
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

      final request = await http.put(
          FunctionConfig.host + 'manageCart/normal/' + key,
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(data));
      if (request.statusCode == 200) {
        // Updating the item quamtity in our local state
        for (var c in _cart) {
          if (c.key == key) {
            c.quantity = quantity;
            break;
          }
        }
        LOG.i(_cart.length);
        _cart.removeWhere((element) => element.quantity == 0);
        LOG.i(_cart.length);

        print(request.body);
      } else {
        print(request.body);
      }
    } catch (e) {
      print(e.toString());
      throw Exception(e);
    }
  }

  //Delete Cart Details
  Future<void> deleteCartDetails(
    String key,
  ) async {
    try {
      final request = await http.delete(
        FunctionConfig.host + 'manageCart/normal/${key}',
      );
      if (request.statusCode == 200) {
        LOG.i(_cart.length);
        for (var e in _cart) {}
        LOG.i('Removing Key ${key}');
        _cart.removeWhere((element) => element.key.compareTo(key) == 0);
        LOG.i(_cart.length);
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
