import 'package:flutter/material.dart';

class Tracking {
  final double status;
  final DateTime date;
  final String comments;

  const Tracking({
    @required this.status,
    @required this.date,
    @required this.comments,
  });
}
