import 'package:flutter/material.dart';
import 'package:living_desire/models/ordered_product.dart';
import './models.dart';

class Order {
  // Model for orders
  final String placedDate;
  // List of ordered Products
  //OrderedProduct: Model
  final List<OrderedProduct> orderedProducts;
  final DateTime expectedDeliveryDate;
  final DateTime deliveryDate;
  final double status;
  final String shipmentID;
  final String courierProvider;
  final ContactInformation contactInformation;
  final String deliveryAddressID;
  // List of tracking data of different ordered products
  final List<Tracking> tracking;
  //final Payment payment;
  final String orderID;

  const Order({
    this.deliveryAddressID,
    this.shipmentID,
    this.courierProvider,
    this.contactInformation,
    @required this.placedDate,
    @required this.orderedProducts,
    @required this.expectedDeliveryDate,
    @required this.deliveryDate,
    @required this.status,
    @required this.tracking,
    @required this.orderID,
  });

  factory Order.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print(data.toString());

    return Order();
  }
}
