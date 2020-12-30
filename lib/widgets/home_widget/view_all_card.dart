import 'package:flutter/material.dart';

class ViewAllCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: ViewAllCardContent(),
    );
  }
}

class ViewAllCardContent extends StatelessWidget {
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
                        "VIEW ALL",
                        style: TextStyle(fontSize: 30),
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
