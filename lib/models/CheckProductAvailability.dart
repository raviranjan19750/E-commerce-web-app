import 'package:cloud_firestore/cloud_firestore.dart';

class CheckProductAvailability {
  final String responseText;
  final int responseCode;
  final DateTime expectedDeliveryDate;

  CheckProductAvailability(
      {this.responseText, this.responseCode, this.expectedDeliveryDate});

  factory CheckProductAvailability.fromJson(Map<String, dynamic> data, int statusCode) {
    print(data.toString());

    if (statusCode == 200) {
      return CheckProductAvailability(
        responseCode: statusCode,
        responseText: data['responseText'],
        expectedDeliveryDate: new Timestamp(
                data['expectedDeliveryDate']["_seconds"],
                data['expectedDeliveryDate']["_nanoseconds"])
            .toDate(),
      );
    }

    return CheckProductAvailability(
      responseCode: statusCode,
      responseText: data['responseText'],
      // expectedDeliveryDate: new Timestamp(data['expectedDeliveryDate']["_seconds"], data['expectedDeliveryDate']["_nanoseconds"])
      //     .toDate(),
    );
  }
}
