import 'package:cloud_firestore/cloud_firestore.dart';

class CheckProductAvailability {
  final String responseText;
  final int responseCode;
  final DateTime expectedDeliveryDate;

  CheckProductAvailability(
      {this.responseText, this.responseCode, this.expectedDeliveryDate});

  factory CheckProductAvailability.fromJson(Map<String, dynamic> data) {
    print(data.toString());
    return CheckProductAvailability(
      responseCode: data['responseCode'],
      responseText: data['responseText'],
      expectedDeliveryDate: new Timestamp(
              data['expectedDeliveryDate']["_seconds"],
              data['expectedDeliveryDate']["_nanoseconds"])
          .toDate(),
    );
  }
}
