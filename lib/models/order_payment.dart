class OrderPayment {

  final String transactionID;

  final int manufacturingPrice,sellingPrice,discountPrice,paymentMode,deliveryCharges,status;

  final DateTime paidDate,payableDate;

  OrderPayment(
  {this.transactionID,
      this.manufacturingPrice,
      this.sellingPrice,
      this.discountPrice,
      this.paymentMode,
      this.deliveryCharges,
      this.status,
      this.paidDate,
      this.payableDate});
}