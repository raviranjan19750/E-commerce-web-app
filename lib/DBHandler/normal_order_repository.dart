import 'dart:convert';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/models/models.dart';
import 'package:http/http.dart' as http;

class NormalOrderRepository {
  Future<List<Order>> getNormalOrderDetails(String authID) async {
    try {
      print('Sending Cart Http Request');
      final response = await http
          .get(FunctionConfig.host + 'manageOrders/normal-list/${authID}');
      if (response.statusCode == 200) {
        print('Http Get request sucessfull');
        print(jsonDecode(response.body).toString());
        return (jsonDecode(response.body) as List)
            .map((i) => Order.fromJson(i))
            .toList();
      } else {
        print('Http Request Failed');
      }
    } catch (e) {
      print('Function Error:' + e.toString());
      throw Exception(e);
    }
  }
}
