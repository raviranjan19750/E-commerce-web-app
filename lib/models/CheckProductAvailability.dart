import 'package:cloud_firestore/cloud_firestore.dart';

class CheckProductAvailability {
  final String responseText;
  final int responseCode;
  final DateTime expectedDeliveryDate;

  CheckProductAvailability(
      { this.responseText, this.responseCode, this.expectedDeliveryDate});

  factory CheckProductAvailability.fromJson(Map<String, dynamic> data) {



    return CheckProductAvailability(
        responseText: data["responseText"],
        responseCode: int.parse(data["responseCode"]),
        expectedDeliveryDate:  new Timestamp(data['expectedDeliveryDate']["_seconds"] , data['expectedDeliveryDate']["_nanoseconds"] ).toDate(),
    );
  }

}
