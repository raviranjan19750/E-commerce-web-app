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

  //Change Quantity Cart Details
  Future<void> changeQuantityCartDetails(
    String key,
    double quantity,
  ) async {
    try {
      var params = {
        "quantity": quantity,
      };
      final response = await http.put(
        FunctionConfig.host + 'manageCart/normal/${key}',
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

  //Delete Cart Details
  Future<void> deleteCartDetails(
    String key,
  ) async {
    try {
      final response = await http.delete(
        FunctionConfig.host + 'manageCart/normal/${key}',
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
