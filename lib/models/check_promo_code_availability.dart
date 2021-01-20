import 'package:living_desire/models/payment_data.dart';

class CheckPromoCodeAvailability {
  final String responseText;
  final double discount;
  final double newPayingAmount;
  final PaymentData paymentData;
  final int couponType;
  final double taxAmount;

  CheckPromoCodeAvailability({
    this.responseText,
    this.newPayingAmount,
    this.discount,
    this.paymentData,
    this.couponType,
    this.taxAmount,
  });

  factory CheckPromoCodeAvailability.fromJson(Map<String, dynamic> data) {
    if (data['couponType'] == 102) {
      return CheckPromoCodeAvailability(
        responseText: data['message'],
        newPayingAmount: data['totalPayingAmount'],
        discount: data['couponDiscount'],
        paymentData: PaymentData.fromJson(data['paymentData']),
        couponType: data["couponType"],
        taxAmount: data["taxAmount"],
      );
    }
    if (data["couponType"] == 103) {
      return CheckPromoCodeAvailability(
        responseText: data['message'],
        discount: data["couponDiscount"],
        couponType: data["couponType"],
      );
    }

    return CheckPromoCodeAvailability(
      responseText: data['message'],
      couponType: data["couponType"],
    );
  }
}
