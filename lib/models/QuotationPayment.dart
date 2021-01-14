class QuotationPayment{

  double payingAmount, tax, totalPayingAmount,unpaidAmount,paidAmount,deliveryCharges;

  String razorpayOrderID, orderID;

  QuotationPayment({this.payingAmount, this.tax, this.totalPayingAmount,
    this.unpaidAmount, this.razorpayOrderID, this.orderID,this.paidAmount,this.deliveryCharges});


  factory QuotationPayment.fromJson(Map<String, dynamic> data) {

    if (data == null) return null;


    return QuotationPayment(
      payingAmount: data['payingAmount'],
      tax: data['tax'],
      totalPayingAmount: data['totalPayingAmount'],
      unpaidAmount: data['unpaidAmount'],
      razorpayOrderID: data['paymentData']['razorpayOrderID'],
      orderID: data['paymentData']['orderID'],
      paidAmount: data['paidAmount'],
      deliveryCharges: data['deliveryCharges'],

    );
  }

}