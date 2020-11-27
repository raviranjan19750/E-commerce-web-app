import 'package:flutter/material.dart';
import '../../config/configs.dart';
import '../widgets.dart';
import '../../models/models.dart';

class OrderPlacedStatusContainer extends StatelessWidget {
  final Order order;

  const OrderPlacedStatusContainer({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(Strings.deliveryAddress +
              order.contactInformation.name +
              order.contactInformation.addressLine),
          //Phone Number
          Text(Strings.phoneNumber + order.contactInformation.phone),
          TrackingStatusBar(),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Palette.secondaryColor,
              borderRadius: BorderRadius.circular(4.0),
            ),
            // Place Order Button
            child: InkWell(
              onTap: () {},
              child: Text(
                Strings.downloadInvoice,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(
                width: 0.5,
                color: Colors.black,
                style: BorderStyle.solid,
              ),
            ),

            // Place Order Button
            child: InkWell(
              onTap: () {},
              child: Text(
                Strings.continueShopping,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
