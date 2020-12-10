import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:living_desire/models/ordered_product.dart';
import './models.dart';

class Order {
  // Model for orders
  final String key;
  final DateTime placedDate;
  // List of ordered Products
  //OrderedProduct: Model
  final String name;
  final List<OrderedProduct> orderedProducts;
  final DateTime expectedDeliveryDate;
  final DateTime deliveryDate;
  final double status;
  final String address;
  final String phone;
  final String pincode;
  final double amount;
  // List of tracking data of different ordered products
  final List<Tracking> tracking;
  final String statusValue;
  //final Payment payment;
  final String orderID;

  const Order({
    this.key,
    this.name,
    this.pincode,
    this.statusValue,
    this.phone,
    this.address,
    this.amount,
    this.placedDate,
    this.orderedProducts,
    this.expectedDeliveryDate,
    this.deliveryDate,
    this.status,
    this.tracking,
    this.orderID,
  });

  factory Order.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print('Data Model: ' + data.toString());

    return Order(
      key: data['id'],
      //placedDate: DateTime.parse(data['data']['placedDate'].toString()),
      // expectedDeliveryDate: DateTime.fromMillisecondsSinceEpoch(
      //     data['data']['expectedDeliveryDate'] * 1000),
      // deliveryDate: DateTime.fromMillisecondsSinceEpoch(
      //     data['data']['deliveryDate'] * 1000),

      name: data['data']['name'],
      address: data['data']['address'],
      phone: data['data']['phone'],
      pincode: data['data']['pincode'],
      orderID: data['data']['orderID'],
      status: data['data']['status'],
      statusValue: data['data']['statusValue'],
      amount: data['data']['amount'],
      tracking: (((data['data']['tracking']) as List)
          .map((tracking) => Tracking.fromJson(tracking))
          .toList()),
      orderedProducts: ((data['data']['products']) as List)
          .map((product) => OrderedProduct.fromJson(product))
          .toList(),
    );
  }
}
