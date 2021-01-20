import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:living_desire/screens/tracking/order_tracking.dart';
import 'package:living_desire/service/navigation_service.dart';
import 'package:living_desire/widgets/OrderTimeline.dart';
import '../../config/configs.dart';
import '../../main.dart';
import '../../routes.dart';
import '../widgets.dart';
import '../../models/models.dart';
import 'dart:html' as html;

class OrderPlacedStatusContainer extends StatelessWidget {
  final Order order;

  String dateFormatter(DateTime date) {
    return new DateFormat.yMMMd().format(date);
  }

  void showTrackingDialog(
      BuildContext context, List<Tracking> list, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                OrderTracking(
                  tracks: list,
                  title: title,
                ),
              ],
            ),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      'Go Bak',
                      style: TextStyle(color: Palette.secondaryColor),
                    ),
                  ))
            ],
          );
        });
  }

  const OrderPlacedStatusContainer({Key key, this.order}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 32),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 2),
                blurRadius: 4.0,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'Placed On           :',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Text(
                        ' ${dateFormatter(order.placedDate)}',
                        style: TextStyle(color: Palette.secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'Delivery Address :',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      width: 320,
                      margin: EdgeInsets.only(left: 24),
                      child: Text(
                        '${order.address} \nPincode : ${order.pincode}',
                        style: TextStyle(color: Palette.secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 16),
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        'Phone Number   :',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 24),
                      child: Text(
                        ' ${order.phone}',
                        style: TextStyle(color: Palette.secondaryColor),
                      ),
                    ),
                  ],
                ),
              ),

              /*   Text(Strings.deliveryAddress + order.name + order.address),
              //Phone Number
              Text(Strings.phoneNumber + order.phone),*/

              InkWell(
                onTap: () {
                  List<Tracking> temp = new List.from(order.tracking.reversed);
                  showTrackingDialog(context, temp, "Order Tracking");
                },
                child: Container(
                  width: 400,
                  padding: EdgeInsets.all(16),
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
                  child: Text(
                    'Track Order',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: InkWell(
                  onTap: () {
                    html.window.open(order.orderInvoiceUrl, '');
                  },
                  child: Container(
                    width: 400,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Palette.secondaryColor,
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                    // Place Order Button
                    child: Text(
                      Strings.downloadInvoice,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  locator<NavigationService>()
                      .navigateTo(RoutesConfiguration.HOME_PAGE);
                },
                child: Container(
                  width: 400,
                  padding: EdgeInsets.all(16),
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
                  child: Text(
                    Strings.continueShopping,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
