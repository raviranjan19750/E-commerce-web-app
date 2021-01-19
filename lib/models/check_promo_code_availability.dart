import 'package:living_desire/models/payment_data.dart';

class CheckPromoCodeAvailability {
  final String responseText;
  final double discount;
  final double newPayingAmount;
  final PaymentData paymentData;
  final double cashbackAmount;

  CheckPromoCodeAvailability({
    this.responseText,
    this.newPayingAmount,
    this.discount,
    this.paymentData,
    this.cashbackAmount,
  });

  factory CheckPromoCodeAvailability.fromJson(Map<String, dynamic> data) {
    print(data.toString());
    if (data['newPayingAmount'] != null) {
      return CheckPromoCodeAvailability(
        responseText: data['message'],
        newPayingAmount: data['newPayingAmount'],
        discount: data['discount'],
        paymentData: PaymentData.fromJson(data['paymentData']),
        cashbackAmount: null,
      );
    }
    if (data["cashbackAmount"] != null) {
      return CheckPromoCodeAvailability(
        responseText: data['message'],
        cashbackAmount: data["cashbackAmount"],
      );
    }

    return CheckPromoCodeAvailability(
      responseText: data['message'],
      newPayingAmount: null,
      discount: null,
      paymentData: null,
      cashbackAmount: null,
    );
  }
}
