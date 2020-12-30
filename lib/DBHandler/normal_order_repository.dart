import 'dart:convert';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class NormalOrderRepository {
  // Initialising Local Order List
  List<Order> _order = List.empty();

  // Getting orders
  List<Order> get order => _order;

  Future<List<Order>> getNormalOrderDetails(String authID) async {
    try {
      print('Sending Cart Http Request');
      final response = await http
          .get(FunctionConfig.host + 'manageOrders/normal-list/${authID}');
      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
        _order = (jsonDecode(response.body) as List<dynamic>)
            .map((i) => Order.fromJson(i))
            .toList();
        return _order;
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print('Function Error:' + e.toString());
      throw Exception(e);
    }
  }

  Future<void> addNormalOrderRatingDetails({
    String authID,
    String orderID,
    String productID,
    String variantID,
    double rating,
    String review,
  }) async {
    try {
      var params = {
        "orderID": orderID,
        "productID": productID,
        "variantID": variantID,
        "rating": rating,
        "review": review,
      };
      final response = await http.post(
        FunctionConfig.host + 'manageRating/${authID}',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params),
      );
      if (response.statusCode == 200) {
        print('Http Post request sucessfull');
        // print(jsonDecode(response.body).toString());
        for (var o in _order) {
          if (o.orderID == orderID) {
            o.orderedProducts.map((e) {
              if (e.variantID == variantID) {
                e.rating = rating;
                e.review = review;
              }
            });
          }
        }
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print('Function Error:' + e.toString());
      throw Exception(e);
    }
  }

  Future<void> editNormalOrderRatingDetails({
    String productID,
    String key,
    double previousRating,
    double rating,
    String review,
  }) async {
    try {
      var params = {
        "previousRating": previousRating,
        "rating": rating,
        "review": review,
      };

      final response = await http.post(
        FunctionConfig.host + 'manageRating/${productID}/${key}',
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params),
      );

      if (response.statusCode == 200) {
        print('Http Post request sucessfull');
        // print(jsonDecode(response.body).toString());
        for (var o in _order) {
          if (o.key == key) {
            o.orderedProducts.map((e) {
              if (e.productID == productID) {
                e.rating = rating;
                e.review = review;
              }
            });
          }
        }
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print('Function Error:' + e.toString());
      throw Exception(e);
    }
  }
}
