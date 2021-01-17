import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';

class Tracking {
  final double status;
  final DateTime date;
  final String comments;
  final String statusValue;

  const Tracking({
    this.status,
    this.date,
    this.comments,
    this.statusValue
  });

  factory Tracking.fromJson(dynamic data) {
    if (data == null) return null;
    print(data.toString());

    return Tracking(
      status: data['status'],
      date: Jiffy(new Timestamp(
                  data['date']["_seconds"], data['date']["_nanoseconds"])
              .toDate()
              .toLocal())
          .add(hours: 5, minutes: 30),
      comments: data['comments'],
      statusValue: data['statusValue'],
    );
  }
}
