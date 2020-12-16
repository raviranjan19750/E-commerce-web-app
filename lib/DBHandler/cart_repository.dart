import 'dart:convert';
import 'package:living_desire/config/function_config.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class CartRepository {
  // Get Cart Details
  Future<List<Cart>> getCartDetails(String authID) async {
    try {
      final response =
          await http.get(FunctionConfig.host + 'manageCart/normal/${authID}');
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
