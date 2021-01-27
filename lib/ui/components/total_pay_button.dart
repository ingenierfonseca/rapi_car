import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/core/services/stripe_service.dart';
import 'package:rapi_car_app/ui/bloc/payment/payment_bloc.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/home/payment/payment_completed_completed.dart';
import 'package:stripe_payment/stripe_payment.dart';

class TotalPayButton extends StatelessWidget {
  const TotalPayButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final widt = MediaQuery.of(context).size.width;

    return Container(
      width: widt,
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30)
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('250.55 USD', style: TextStyle(fontSize: 20))
            ],
          ),
          BlocBuilder<PaymentBloc, PaymentState>(
            builder: (context, state) {
              return _BtnPay(state);
            },
          )
        ],
      ),
    );
  }
}

class _BtnPay extends StatelessWidget {
  final PaymentState state;

  _BtnPay(this.state);

  @override
  Widget build(BuildContext context) {
    return state.targetIsActive
    ? buildTargetButton(context)
    : buildAppleAndGooglePay(context);
  }

  Widget buildTargetButton(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 170,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(FontAwesomeIcons.solidCreditCard, color: Colors.white),
          SizedBox(width: 5),
          Text('Pagar', style: TextStyle(color: Colors.white, fontSize: 22))
        ],
      ),
      onPressed: () async {
        //showLoading(context);

        final stripeService = StripeService();
        final monthYear = state.creditCard.expiracyDate.split('/');

        final resp = await stripeService.payExistentCard(
          amount: state.amuntString, 
          currency: state.currency, 
          card: CreditCard(
            number: state.creditCard.cardNumber,
            expMonth: int.parse(monthYear[0]),
            expYear: int.parse(monthYear[1])
          )
        );

        //Navigator.pop(context);
        //if (resp.ok)
          //showAlert(context, 'Reserva', 'message');
        //else
          //showAlert(context, 'Fallo', resp.msg);
        //final resp = await stripeService.payNewCard(amount: state.amuntString, currency: state.currency);
      },
    );
  }
  
  Widget buildAppleAndGooglePay(BuildContext context) {
    return MaterialButton(
      height: 45,
      minWidth: 150,
      shape: StadiumBorder(),
      elevation: 0,
      color: Colors.black,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Platform.isAndroid
            ? FontAwesomeIcons.google
            : FontAwesomeIcons.apple, color: Colors.white),
          SizedBox(width: 5),
          Text('Pagar', style: TextStyle(color: Colors.white, fontSize: 22))
        ],
      ),
      onPressed: () async {
        final stripeService = StripeService();

        final resp = await stripeService.payApplePayGooglePay(
          amount: state.amuntString, 
          currency: state.currency
        );
        //context.push(page: PaymentCompletedView());
      }
    );
  }
}