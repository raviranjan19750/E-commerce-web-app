import 'package:flutter/material.dart';

class QuotationTracking {
  final double status;
  final DateTime date;
  final String comments;

  const QuotationTracking({
    @required this.status,
    @required this.date,
    @required this.comments,
  });
}
