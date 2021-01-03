import 'package:flutter/material.dart';
import 'package:living_desire/config/configs.dart';
import 'package:living_desire/main.dart';
import 'package:living_desire/routes.dart';
import 'package:living_desire/service/navigation_service.dart';

class ViewAllCard extends StatelessWidget {

  final String routeString;

  const ViewAllCard({Key key, this.routeString}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ViewAllCardContent(routeString: routeString,),
    );
  }
}

class ViewAllCardContent extends StatelessWidget {


  final String routeString;

  const ViewAllCardContent({Key key, this.routeString}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: InkWell(
                onTap: () {
                  locator<NavigationService>().navigateTo(
                    RoutesConfiguration.SEARCH_ALL_PRODUCT,
                    queryParams: {
                      "search": routeString,
                    },
                  );

                  // Navigator.pushNamed(
                  //     context, RoutesConfiguration.PRODUCT_DETAIL,
                  //     arguments: {
                  //       "product": product,
                  //       "productID": product.productId,
                  //       "variantID": product.varientId
                  //     });
                },
                child: Container(
                  child: Center(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Strings.viewMore.toUpperCase(),
                        style: TextStyle(fontSize: 24),
                      ),
                      Icon(Icons.navigate_next_sharp)
                    ],
                  )),
                )),
          ),
        )
      ],
    );
  }
}
