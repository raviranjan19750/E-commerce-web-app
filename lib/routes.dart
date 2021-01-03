import 'package:flutter/material.dart';
import 'package:living_desire/models/routing_data.dart';
import 'package:living_desire/screens/ProductDetailScreen/ProductDetailScreeen.dart';
import 'package:living_desire/screens/all_product/all_product_screen.dart';
import 'package:living_desire/screens/bulk_order/bulk_order.dart';
import 'package:living_desire/screens/bulk_order/bulk_order_quotation.dart';
import 'package:living_desire/screens/home_screen/home_screen.dart';
import 'package:living_desire/screens/my_orders/my_bulk_order.dart';
import 'package:living_desire/screens/my_orders/my_order.dart';
import 'package:living_desire/screens/screens.dart';
import 'package:living_desire/extension/string_extension.dart';

import 'logger.dart';

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;
  final Widget Function(BuildContext, RoutingData) builder;
}

class RoutesConfiguration {
  static var LOG = LogBuilder.getLogger();

  static const String HOME_PAGE = "/";
  static const String SEARCH_ALL_PRODUCT = "/all";
  static const String PRODUCT_DETAIL = "/product";
  static const String BULK_ORDER = "/bulkorder";
  static const String ORDER = "/orders";
  static const String WISHLIST = "/wishlist";
  static const String MY_ORDERS = "/myorders";
  static const String MY_BULK_ORDERS = "/mybulkorders";
  static const String CART = "/cart";
  static const String BULK_ORDER_QUOTATION = "/customorderquotation";
  static const String MANAGE_ADDRESSES = "/manageaddresses";
  static const String SELECT_ADDRESS = "/selectaddress";
  static const String ORDER_PLACED = "/orderplaced";

  static List<Path> paths = [
    Path(
      r'^' + SEARCH_ALL_PRODUCT,
      (context, data) => AllProductScreen(
        searchFilter: data['search'],
      ),
    ),
    Path(r'^' + PRODUCT_DETAIL, (context, data) {
      print(data);
      return MyDesktopView(
        child: ProductDetailScreen(
          productID: data['pid'],
          variantID: data['vid'],
        ),
      );
    }),
    Path(r'^' + CART,
        (context, data) => MyDesktopView(child: CartScreenDesktop())),
    Path(
      r'^' + BULK_ORDER,
      (context, data) => BulkOrder(

        productID: data['productID'],
        variantID: data['variantID'],
        productType: data['productType'],
        productSubType: data['productSubType'],
        size: data['size'],


      ),
    ),
    Path(
      r'^' + ORDER,
      (context, data) => MyOrder(),
    ),
    Path(
      r'^' + MY_BULK_ORDERS,
      (context, data) => MyBulkOrder(),
    ),
    Path(
      r'^' + WISHLIST,
      (context, data) => MyDesktopView(child: WishlistScreenDesktop()),
    ),
    Path(
      r'^' + MY_ORDERS,
      (context, data) => MyDesktopView(child: OrderScreenDesktop()),
    ),
    Path(r'^' + BULK_ORDER_QUOTATION,
        (context, data) => BulkOrderQuotation(id: data['key'])),
    Path(
      r'^' + HOME_PAGE,
      (context, data) => HomeScreen(),
    ),
  ];

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      RoutingData data = settings.name.getRoutingData;
      if (regExpPattern.hasMatch(data.route)) {
        final firstMatch = regExpPattern.firstMatch(data.route);
        LOG.i("Routing to ${settings.name}");
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, data),
          settings: settings,
        );
      }
    }

    // If no match was found, we let [WidgetsApp.onUnknownRoute] handle it.
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ));
  }

  static Route<dynamic> onGenerateRoutes(RouteSettings settings) {
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
            builder: (_) => MyDesktopView(
                    child: SelectAddressScreenDesktop(
                  isCustomOrder: isBulkOrder,
                  isSampleRequested: sampleRequested,
                  totalItems: totalItems,
                )));
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
