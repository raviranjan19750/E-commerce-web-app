
import 'package:living_desire/models/routing_data.dart';

extension StringExtensions on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(route: uriData.path, queryParameters: uriData.queryParameters);
  }
}