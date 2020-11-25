import 'package:flutter/material.dart';
import 'package:living_desire/models/ordered_product.dart';
import './models.dart';

class Order {
  // Model for orders
  final String datePlaced;
  // List of ordered Products
  //OrderedProduct: Model
  final List<OrderedProduct> orderedProducts;
  final DateTime expectedDeliveryDate;
  final DateTime deliveryDate;
  final double status;
  final String shipmentID;
  final String courierProvider;
  final ContactInformation contactInformation;

  // List of tracking data of different ordered products
  final List<Tracking> tacking;
  //final Payment payment;
  final String orderID;

  const Order({
    this.shipmentID,
    this.courierProvider,
    this.contactInformation,
    @required this.datePlaced,
    @required this.orderedProducts,
    @required this.expectedDeliveryDate,
    @required this.deliveryDate,
    @required this.status,
    @required this.tacking,
    @required this.orderID,
  });
}
