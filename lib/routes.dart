import 'package:flutter/material.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailScreeen.dart';
import 'package:living_desire/screens/all_product/all_product_screen.dart';
import 'package:living_desire/screens/bulk_order/bulk_order.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_quotation.dart';
import 'package:living_desire/screens/home_screen/home_screen.dart';
import 'package:living_desire/screens/my_orders/my_bulk_order.dart';
import 'package:living_desire/screens/my_orders/my_order.dart';
import 'package:living_desire/screens/screens.dart';

class RoutesConfiguration {
  static const String HOME_PAGE = "/";
  static const String SEARCH_ALL_PRODUCT = "/all";
  static const String PRODUCT_DETAIL = "/product";
  static const String BULK_ORDER = "/bulkorder";
  static const String ORDER = "/orders";
  static const String WISHLIST = "/wishlist";
  static const String MY_ORDERS = "/myorders";
  static const String MY_BULK_ORDERS = "/mybulkorders";
  static const String BULK_ORDER_QUOTATION = "/bulkorderquotation";
  static const String CART = "/cart";
  static const String MANAGE_ADDRESSES = "/manageaddresses";
  static const String SELECT_ADDRESS = "/selectaddress";
  static const String ORDER_PLACED = "/orderplaced";

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_PAGE:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case SEARCH_ALL_PRODUCT:
        var searchFilter = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => AllProductScreen(
                  searchFilter: searchFilter,
                ));
      case PRODUCT_DETAIL:
        var args = settings.arguments as Map;
        var product = args["product"];
        var productID = args["productID"];
        var variantID = args["variantID"];
        return MaterialPageRoute(
            builder: (context) => MyDesktopView(
                    child: ProductDetailScreen(
                  productID: productID,
                  variantID: variantID,
                  product: product,
                )));
      case BULK_ORDER:
        return MaterialPageRoute(builder: (_) => BulkOrder());
      case ORDER:
        return MaterialPageRoute(builder: (_) => MyOrder());

      case MY_BULK_ORDERS:
        return MaterialPageRoute(builder: (_) => MyBulkOrder());

      case BULK_ORDER_QUOTATION:

        var args = settings.arguments as Map;
        String key = args["key"];

        return MaterialPageRoute(builder: (_) => BulkOrderQuotation(id: key,));
        
      case WISHLIST:
        return MaterialPageRoute(
            builder: (_) => MyDesktopView(child: WishlistScreenDesktop()));
      case MY_ORDERS:
        return MaterialPageRoute(
            builder: (_) => MyDesktopView(child: OrderScreenDesktop()));
      case CART:
        return MaterialPageRoute(
            builder: (_) => MyDesktopView(child: CartScreenDesktop()));
      case MANAGE_ADDRESSES:
        return MaterialPageRoute(
            builder: (_) =>
                MyDesktopView(child: ManageAddressesScreenDesktop()));
      case SELECT_ADDRESS:

        var args = settings.arguments as Map;
        bool sampleRequested = args["sampleRequested"];
        bool isBulkOrder = args["isBulkOrder"];
        int totalItems = args["totalItems"];
        return MaterialPageRoute(
            builder: (_) => MyDesktopView(child: SelectAddressScreenDesktop(isCustomOrder: isBulkOrder,isSampleRequested: sampleRequested,totalItems: totalItems,)));
      case ORDER_PLACED:
        return MaterialPageRoute(
            builder: (_) => MyDesktopView(child: OrderPlacedScreenDesktop()));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
