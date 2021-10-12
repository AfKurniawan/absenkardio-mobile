class CheckoutModel {
  bool error;
  String messages;
  Checkout checkout;

  CheckoutModel({this.error, this.messages, this.checkout});

  CheckoutModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    messages = json['messages'];
    checkout = json['checkout'] != null
        ? new Checkout.fromJson(json['checkout'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['messages'] = this.messages;
    if (this.checkout != null) {
      data['checkout'] = this.checkout.toJson();
    }
    return data;
  }
}

class Checkout {
  String timeout;
  String locationOut;
  String statusTimein;
  String reason;
  String selfie;
  String totalhours;
  int isCheckout;

  Checkout(
      {this.timeout,
        this.locationOut,
        this.statusTimein,
        this.reason,
        this.selfie,
        this.totalhours,
        this.isCheckout});

  Checkout.fromJson(Map<String, dynamic> json) {
    timeout = json['timeout'];
    locationOut = json['location_out'];
    statusTimein = json['status_timein'];
    reason = json['reason'];
    selfie = json['selfie'];
    totalhours = json['totalhours'];
    isCheckout = json['isCheckout'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeout'] = this.timeout;
    data['location_out'] = this.locationOut;
    data['status_timein'] = this.statusTimein;
    data['reason'] = this.reason;
    data['selfie'] = this.selfie;
    data['totalhours'] = this.totalhours;
    data['isCheckout'] = this.isCheckout;
    return data;
  }
}
