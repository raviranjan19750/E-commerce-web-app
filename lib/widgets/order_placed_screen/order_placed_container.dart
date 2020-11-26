import 'package:flutter/material.dart';
import '../../config/configs.dart';
import '../../models/models.dart';
import '../widgets.dart';

class OrderPlacedContainer extends StatelessWidget {
  final Order order;

  const OrderPlacedContainer({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(Strings.orderPlaced),
            Expanded(
              child: Container(
                child: ListView.builder(
                  primary: false,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: order.orderedProducts.length,
                  itemBuilder: (context, index) {
                    return OrderPlacedItem(
                        orderedProduct: order.orderedProducts[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
