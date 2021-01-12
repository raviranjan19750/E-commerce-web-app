class SamplePayment{

  double payingAmount, tax, totalPayingAmount,deliveryCharges;

  String razorpayOrderID, orderID;

  SamplePayment({this.payingAmount, this.tax, this.totalPayingAmount,
      this.deliveryCharges, this.razorpayOrderID, this.orderID});


  factory SamplePayment.fromJson(Map<String, dynamic> data) {

    if (data == null) return null;


    return SamplePayment(
      payingAmount: data['data']['payingAmount'],
      tax: data['data']['tax'],
      totalPayingAmount: data['data']['totalPayingAmount'],
      deliveryCharges: data['data']['deliveryCharges'],
      razorpayOrderID: data['data']['paymentData']['razorpayOrderID'],
      orderID: data['data']['paymentData']['orderID'],

    );
  }


}