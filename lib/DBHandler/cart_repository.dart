import 'dart:convert';
import 'dart:math';
import 'package:living_desire/DBHandler/local_storage.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/config/strings.dart';
import 'package:living_desire/models/localNormalCart.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

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

  void addCartLocalData(List<Cart> cart) {
    _cart = cart;
  }

  void changeCartLocalData(String key, int quantity) {
    for (var c in _cart) {
      if (c.key == key) {
        c.quantity = quantity;
        break;
      }
    }

    _cart.removeWhere((element) => element.quantity == 0);
  }

  void deleteCartLocalData(String key) {
    _cart.removeWhere((element) => element.key == key);
  }

  Future<List<Cart>> getCartDetails(String authID) async {
    LOG.v('Requesting all cart details for ${authID}');
    try {
      if (authID != null) {
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
      } else {
        final _cartlist = Hive.box<NormalCartLocal>('cart_items');
        Map<dynamic, NormalCartLocal> cartMap = _cartlist.toMap();
        var data = [];
        var keys = [];
        cartMap.forEach((key, value) {
          var keyData = {
            "key": key,
            "variantID": value.variantID,
          };
          keys.add(keyData);
          var cartData = {
            "productID": value.productID,
            "variantID": value.variantID,
            "quantity": value.quantity
          };
          data.add(cartData);
        });

        List<Cart> cart = [];
        var response = await CloudFunctionConfig.post(
            'manageAnonymousUser/get-normal-cart', data);
        if (response.statusCode == 200) {
          cart = (jsonDecode(response.body) as List).map((e) {
            for (int i = 0; i < keys.length; i++) {
              if (e['variantID'] == (keys[i])["variantID"]) {
                return Cart.fromJsonMap(e, (keys[i])["key"]);
              }
            }
          }).toList();

          _cart = cart;
          return _cart;
        }
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

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

  // Add Cart Details
  Future<void> addCartDetails(
    String authID,
    String productID,
    String variantID,
    int quantity,
  ) async {
    try {
      if (authID != null) {
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
      } else {
        final _cartlist = Hive.box<NormalCartLocal>('cart_items');
        Map<dynamic, NormalCartLocal> cartMap = _cartlist.toMap();
        Cart itm = new Cart(
          key: _getAutoId(),
          productID: productID,
          variantID: variantID,
          quantity: quantity,
        );
        bool isInCart = false;
        String existingCartKey;
        int newQuantity;
        cartMap.forEach((key, value) {
          if (value.variantID == itm.variantID) {
            isInCart = true;
            existingCartKey = key;
            newQuantity = value.quantity + quantity;
          }
        });
        if (isInCart == false) {
          NormalLocalStorage(itm).saveToLocalStorage();
        } else {
          NormalLocalStorage(itm)
              .changeQuantityFromLocalStorage(existingCartKey, newQuantity);
        }
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  //Change Quantity Cart Details
  Future<void> changeQuantityCartDetails(
    String key,
    var quantity,
    String authID,
    String productID,
  ) async {
    try {
      if (authID != null) {
        var data = {
          "quantity": quantity,
        };

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
      } else {
        if (quantity == 0) {
          Cart itm = new Cart(
            key: key,
            productID: productID,
          );
          NormalLocalStorage(itm).deleteFromLocalStorage(itm.key);
          _cart.removeWhere((element) => element.key == itm.key);
        } else {
          Cart itm = new Cart(
            key: key,
            productID: productID,
            quantity: quantity,
          );
          NormalLocalStorage(itm)
              .changeQuantityFromLocalStorage(itm.key, itm.quantity);

          for (var c in _cart) {
            if (c.key == key) {
              c.quantity = quantity;
              break;
            }
          }

          _cart.removeWhere((element) => element.quantity == 0);
        }
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }

  //Delete Cart Details
  Future<void> deleteCartDetails({
    String key,
    String authID,
    String productID,
  }) async {
    try {
      if (authID != null) {
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
      } else {
        Cart itm = new Cart(
          key: key,
          productID: productID,
        );
        NormalLocalStorage(itm).deleteFromLocalStorage(itm.key);
        _cart.removeWhere((element) => element.key == itm.key);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }
}
