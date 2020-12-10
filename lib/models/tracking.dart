import 'package:flutter/material.dart';

class Tracking {
  final double status;
  final DateTime date;
  final String comments;

  const Tracking({
    @required this.status,
    this.date,
    @required this.comments,
  });

  factory Tracking.fromJson(Map<String, dynamic> data) {
    if (data == null) return null;
    print(data.toString());

    return Tracking(
      status: data['status'],
      //date: DateTime.fromMillisecondsSinceEpoch(data['date'] * 1000),
      comments: data['comments'],
    );
  }
}
