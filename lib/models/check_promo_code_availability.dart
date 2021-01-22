import 'package:living_desire/models/payment_data.dart';

class CheckPromoCodeAvailability {
  final String responseText;
  final double discount;
  final double newPayingAmount;
  final PaymentData paymentData;
  final int couponType;
  final double taxAmount;
  final String promoCode;

  CheckPromoCodeAvailability({
    this.responseText,
    this.newPayingAmount,
    this.discount,
    this.paymentData,
    this.couponType,
    this.taxAmount,
    this.promoCode,
  });

  factory CheckPromoCodeAvailability.fromJson(
      Map<String, dynamic> data, String promoCode) {
    if (data['couponType'] == 102) {
      return CheckPromoCodeAvailability(
        responseText: data['message'],
        newPayingAmount: data['totalPayingAmount'],
        discount: data['couponDiscount'],
        paymentData: PaymentData.fromJson(data['paymentData']),
        couponType: data["couponType"],
        taxAmount: data["taxAmount"],
        promoCode: promoCode,
      );
    }
    if (data["couponType"] == 103) {
      return CheckPromoCodeAvailability(
          responseText: data['message'],
          discount: data["couponDiscount"],
          couponType: data["couponType"],
          promoCode: promoCode);
    }

    return CheckPromoCodeAvailability(
      responseText: data['message'],
      couponType: data["couponType"],
      promoCode: promoCode,
    );
  }
}
