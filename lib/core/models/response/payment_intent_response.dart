class PaymentIntentResponse {
  String clientSecret;
  String status;

  PaymentIntentResponse({this.status, this.clientSecret});

  PaymentIntentResponse.fromJson(Map<String, dynamic> json) {
    status                    = json['status'];
    clientSecret              = json['clientSecret'];
  }
}