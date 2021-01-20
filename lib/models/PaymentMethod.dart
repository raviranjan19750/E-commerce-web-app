class PaymentMethod {
  String method;

  List<Mode> modes;

  bool enabled;

  PaymentMethod({this.method, this.modes, this.enabled});
}

class Mode {
  int code;
  String description, asset;

  Mode({this.code, this.description, this.asset});
}

class PaymentMethodOptions {
  String method;

  List<Mode> modes;

  bool enabled;

  PaymentMethodOptions({
    this.method,
    this.modes,
    this.enabled,
  });
}
