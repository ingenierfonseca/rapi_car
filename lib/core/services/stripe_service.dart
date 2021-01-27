import 'dart:io';

import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rapi_car_app/core/models/response/payment_intent_response.dart';
import 'package:rapi_car_app/core/models/response/stripe_custom_response.dart';


import 'package:stripe_payment/stripe_payment.dart';

class StripeService {

  //singleton
  StripeService._();
  static final StripeService _instance = StripeService._();
  factory StripeService() {
    return _instance;
  }

  String _paymentApiUrl = 'https://api.stripe.com/v1/payment_intents';
  static String _secretKey = 'sk_test_51I9alcBvCh6fBsQeUzJdICY7PoyUqk1TKFUdvWTWOfSp4zWzBsGn4Y6AtW8LnvMnxF6A9XIBu4J547cDTgkvphwf00XZZL9ca7';
  String _apiKey = 'pk_test_51I9alcBvCh6fBsQe01FLNvMtWF1dSYDgbZMpqbHZr1axmDsIDBVUTWZt9PtBIqdABrlhRyQNuitDZwPc0KkxJDzl00o7OWaWWK';

  final headrOptions = Options(
    contentType: Headers.formUrlEncodedContentType,
    headers: {
      'Authorization': 'Bearer ${StripeService._secretKey}'
    }
  );

  void init() {
    StripePayment.setOptions(
      StripeOptions(
        publishableKey: this._apiKey,
        androidPayMode: 'test',
        merchantId: 'test'
      )
    );
  }

  Future<StripeCustomResponse> payExistentCard({
    @required String amount,
    @required String currency,
    @required CreditCard card
  }) async {
    try {
      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(card: card)
      );

      final resp = await executePay(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false);
    }
  }

  Future<StripeCustomResponse> payNewCard({
    @required String amount,
    @required String currency
  }) async {
    try {
      final paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest()
      );

      final resp = await executePay(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false);
    }
  }

  Future<StripeCustomResponse> payApplePayGooglePay({
    @required String amount,
    @required String currency
  }) async {
    try {
      final newAmount = double.parse(amount) / 100;

      final token = await StripePayment.paymentRequestWithNativePay(
        androidPayOptions: AndroidPayPaymentRequest(
          currencyCode: currency,
          totalPrice: amount
        ),
        applePayOptions: ApplePayPaymentOptions(
          countryCode: 'USD',
          currencyCode: currency,
          items: [
            ApplePayItem(
              label: 'Super producto 1',
              amount: '$newAmount'
            )
          ]
        )
      );

      final paymentMethod = await StripePayment.createPaymentMethod(
        PaymentMethodRequest(
          card: CreditCard(
            token: token.tokenId
          )
        )
      );

      final resp = await executePay(
        amount: amount,
        currency: currency,
        paymentMethod: paymentMethod
      );

      await StripePayment.completeNativePayRequest();

      return resp;
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }

  Future<PaymentIntentResponse> createPayIntent({
    @required String amount,
    @required String currency
  }) async {
    try {
      final dio = Dio();
      final data = {
        'amount': amount,
        'currency': currency
      };

      final resp = await dio.post(
        _paymentApiUrl,
        data: data,
        options: headrOptions
      );

      return PaymentIntentResponse.fromJson(resp.data);

    } catch (e) {
      return PaymentIntentResponse(
        status: '400'
      );
    }
  }

  Future<StripeCustomResponse> executePay({
    @required String amount,
    @required String currency,
    @required PaymentMethod paymentMethod
  }) async {
    try {
      final paymentIntent = await createPayIntent(amount: amount, currency: currency);

      final paymentResult = await StripePayment.confirmPaymentIntent(
        PaymentIntent(
          clientSecret: paymentIntent.clientSecret,
          paymentMethodId: paymentMethod.id
        )
      );

      if (paymentResult.status == 'succeeded') {
        return StripeCustomResponse(ok: false);
      }

      return StripeCustomResponse(ok: false, msg: 'Fallo: ${paymentResult.status}');
    } catch (e) {
      return StripeCustomResponse(ok: false, msg: e.toString());
    }
  }
}