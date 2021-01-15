import 'package:living_desire/models/payment_data.dart';

class NormalCartDetails {
  final double totalAmount;
  final double discount;
  final double deliveryCharges;
  final double payingAmount;
  final int totalItems;
  final PaymentData paymentData;
  final double taxAmount;
  final double walletAmount;

  NormalCartDetails({
    this.totalAmount,
    this.discount,
    this.deliveryCharges,
    this.paymentData,
    this.walletAmount,
    this.payingAmount,
    this.totalItems,
    this.taxAmount,
  });

  factory NormalCartDetails.fromJson(dynamic data) {
    if (data == null) return null;

    return NormalCartDetails(
      taxAmount: data["taxAmount"],
      walletAmount: data["walletAmount"],
      paymentData: PaymentData.fromJson(data["paymentData"]),
      deliveryCharges: data["deliveryCharges"],
      discount: data["discount"],
      payingAmount: data["payingAmount"],
      totalAmount: data["totalAmount"],
      totalItems: data["totalItems"],
    );
  }
}
