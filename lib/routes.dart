import 'package:flutter/material.dart';
import 'package:living_desire/screens/all_product/all_product_screen.dart';
import 'package:living_desire/screens/bulk_order/bulk_order.dart';
import 'package:living_desire/screens/home_screen/home_screen.dart';
import 'package:living_desire/screens/product_detail_screen.dart';

class RoutesConfiguration {

  static const String HOME_PAGE = "/";
  static const String SEARCH_ALL_PRODUCT = "/all";
  static const String PRODUCT_DETAIL = "/product";
  static const String BULK_ORDER = "/bulkorder";
  static const String ORDER = "/myorders";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_PAGE:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case SEARCH_ALL_PRODUCT:
        return MaterialPageRoute(builder: (_) => AllProductScreen());
      case PRODUCT_DETAIL:
        return MaterialPageRoute(builder: (_) => ProductDetailScreen());
      case BULK_ORDER:
        return MaterialPageRoute(builder: (_) => BulkOrder());
      default:
        return MaterialPageRoute(builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}'),),
        ));
    }
  }
}