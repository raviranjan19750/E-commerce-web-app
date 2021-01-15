class CheckPromoCodeAvailability {
  final String responseText;
  final int responseCode;
  final double newPayingAmount;

  CheckPromoCodeAvailability({
    this.responseText,
    this.responseCode,
    this.newPayingAmount,
  });

  factory CheckPromoCodeAvailability.fromJson(Map<String, dynamic> data) {
    if (data['newPayingAmount'] != null) {
      return CheckPromoCodeAvailability(
        responseCode: data['responseCode'],
        responseText: data['responseText'],
        newPayingAmount: data['newPayingAmount'],
      );
    }

    return CheckPromoCodeAvailability(
      responseCode: data['responseCode'],
      responseText: data['responseText'],
    );
  }
}
