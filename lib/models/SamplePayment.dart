class SamplePayment{

  double payingAmount, tax, totalPayingAmount,deliveryCharges;

  String razorpayOrderID, orderID;

  SamplePayment({this.payingAmount, this.tax, this.totalPayingAmount,
      this.deliveryCharges, this.razorpayOrderID, this.orderID});


  factory SamplePayment.fromJson(Map<String, dynamic> data) {

    if (data == null) return null;


    return SamplePayment(
      payingAmount: data['payingAmount'],
      tax: data['tax'],
      totalPayingAmount: data['totalPayingAmount'],
      deliveryCharges: data['deliveryCharges'],
      razorpayOrderID:(data['paymentData']!=null)? data['paymentData']['razorpayOrderID']:null,
      orderID: (data['paymentData']!=null)?data['paymentData']['orderID']:null,

    );
  }


}