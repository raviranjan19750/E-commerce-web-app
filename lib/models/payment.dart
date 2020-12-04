class Payment {
  final double amount;
  final double paymentMode;
  final DateTime paidDate;
  final String transactionID;
  final String couponCode;
  final double discount;
  final double status;
  final double deliveryCharges;

  Payment({
    this.amount,
    this.paymentMode,
    this.paidDate,
    this.transactionID,
    this.couponCode,
    this.discount,
    this.status,
    this.deliveryCharges,
  });
}
