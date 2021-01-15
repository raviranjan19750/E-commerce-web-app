class PaymentData {
  final String razorpayOrderID;
  final String orderID;

  PaymentData({
    this.razorpayOrderID,
    this.orderID,
  });
  factory PaymentData.fromJson(dynamic data) {
    if (data == null) return null;

    return PaymentData(
      razorpayOrderID: data["razorpayOrderID"],
      orderID: data["orderID"],
    );
  }
}
