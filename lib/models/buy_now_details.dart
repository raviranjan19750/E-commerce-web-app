import 'package:living_desire/models/payment_data.dart';

class BuyNowDetails {
  final double totalAmount;
  final double discount;
  final double deliveryCharges;
  final double payingAmount;
  final int totalItems;
  final PaymentData paymentData;
  final double taxAmount;
  final double walletAmount;
  final double totalPayingAmount;
  final List<String> cartKeys;

  BuyNowDetails({
    this.totalAmount,
    this.discount,
    this.totalItems,
    this.deliveryCharges,
    this.payingAmount,
    this.paymentData,
    this.taxAmount,
    this.walletAmount,
    this.cartKeys,
    this.totalPayingAmount,
  });

  factory BuyNowDetails.fromJson(dynamic data) {
    if (data == null) return null;

    return BuyNowDetails(
      taxAmount: data["taxAmount"],
      walletAmount: data["walletAmount"],
      paymentData: PaymentData.fromJson(data["paymentData"]),
      deliveryCharges: data["deliveryCharges"],
      discount: data["discount"],
      payingAmount: data["payingAmount"],
      totalAmount: data["totalAmount"],
      totalItems: data["totalItems"],
      cartKeys: (data["cartKeys"] as List).map((e) => e.toString()).toList(),
      totalPayingAmount: data["totalPayingAmount"],
    );
  }
}
