import 'dart:convert';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class NormalOrderRepository {
  // Initialising Local Order List
  List<Order> _order = List.empty();
  var LOG = Logger();

  // Getting orders
  List<Order> get order => _order;

  Future<List<Order>> getNormalOrderDetails(String authID) async {
    try {
      print('Sending Cart Http Request');
      final response =
          await CloudFunctionConfig.get('manageOrders/normal-list/${authID}');

      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
        _order = (jsonDecode(response.body) as List<dynamic>)
            .map((i) => Order.fromJson(i))
            .toList();
        return _order;
      } else {
        print('Http Request Failed');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
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
      final response =
          await CloudFunctionConfig.post('manageRating/${authID}', params);

      if (response.statusCode == 200) {
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
        LOG.i('Http Request Failed');
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
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

      final response = await CloudFunctionConfig.post(
          'manageRating/${productID}/${key}', params);

      if (response.statusCode == 200) {
        LOG.i('Http Post request sucessfull');
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
        LOG.e(response.body);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      return exception;
    }
  }
}
