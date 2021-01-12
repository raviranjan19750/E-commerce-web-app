class QuotationPayment{

  double payingAmount, tax, totalPayingAmount,unpaidAmount,paidAmount;

  String razorpayOrderID, orderID;

  QuotationPayment({this.payingAmount, this.tax, this.totalPayingAmount,
    this.unpaidAmount, this.razorpayOrderID, this.orderID,this.paidAmount});


  factory QuotationPayment.fromJson(Map<String, dynamic> data) {

    if (data == null) return null;


    return QuotationPayment(
      payingAmount: data['data']['payingAmount'],
      tax: data['data']['tax'],
      totalPayingAmount: data['data']['totalPayingAmount'],
      unpaidAmount: data['data']['unpaidAmount'],
      razorpayOrderID: data['data']['paymentData']['razorpayOrderID'],
      orderID: data['data']['paymentData']['orderID'],
      paidAmount: data['data']['paidAmount'],

    );
  }

}