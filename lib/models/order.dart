import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
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
  final int status;
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

  factory Order.fromJson(dynamic data) {
    if (data == null) return null;

    return Order(
      key: data['id'],
      placedDate: Jiffy(new Timestamp(data['data']['placedDate']["_seconds"],
                  data['data']['placedDate']["_nanoseconds"])
              .toDate()
              .toLocal())
          .add(hours: 5, minutes: 30),
      expectedDeliveryDate: Jiffy(new Timestamp(
                  data['data']['expectedDeliveryDate']["_seconds"],
                  data['data']['expectedDeliveryDate']["_nanoseconds"])
              .toDate()
              .toLocal())
          .add(hours: 5, minutes: 30),
      deliveryDate: (data['data']['deliveryDate'] != null)
          ? Jiffy(new Timestamp(data['data']['deliveryDate']["_seconds"],
                      data['data']['deliveryDate']["_nanoseconds"])
                  .toDate()
                  .toLocal())
              .add(hours: 5, minutes: 30)
          : null,
      name: data['data']['name'],
      address: data['data']['address'],
      phone: data['data']['phone'],
      pincode: data['data']['pincode'],
      orderID: data['data']['orderID'],
      status: data['data']['status'],
      statusValue: data['data']['statusValue'],
      amount: data['data']['amount'],
      tracking: (((data['data']['tracking']) as List<dynamic>)
          .map((tracking) => Tracking.fromJson(tracking))
          .toList()),
      orderedProducts: ((data['data']['products']) as List<dynamic>)
          .map((product) => OrderedProduct.fromJson(product))
          .toList(),
    );
  }
}
