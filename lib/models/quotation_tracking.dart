import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class QuotationTracking {
  final double status;
  final DateTime date;
  final String statusValue;

  const QuotationTracking({
    @required this.status,
    @required this.date,
    @required this.statusValue,
  });

  factory QuotationTracking.fromJson(Map<String, dynamic> data) {

    if (data == null) return null;


    DateTime getDate(Map<String, dynamic> data){

      if(data == null)
        return null;

      return new Timestamp(data['_seconds'], data['_nanoseconds']).toDate();

    }


    return QuotationTracking(

      status: data['status'],
      statusValue: data['statusValue'],
      date: getDate(data['date']),

    );
  }
}
