import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:rapi_car_app/ui/bloc/payment/payment_bloc.dart';
import 'package:rapi_car_app/ui/components/total_pay_button.dart';

class TargetView extends StatefulWidget {
  @override
  _TargetView createState() => _TargetView();
}

class _TargetView extends State<TargetView> {

  @override
  Widget build(BuildContext context) {
    final card = context.bloc<PaymentBloc>().state.creditCard;

    return Scaffold(
      backgroundColor: Color(0xff21232a),
      appBar: AppBar(
        backgroundColor: Color(0xff384879),
        title: Text('Realizar Pago de Reserva')
      ),
      body: Stack(
        children: [
          Container(),
          Hero(
            tag: card.cardNumber,
            child: CreditCardWidget(
              cardNumber: card.cardNumber,
              expiryDate: card.expiracyDate,
              cardHolderName: card.cardHolderName,
              cvvCode: card.cvv,
              showBackView: false
            )
          ),
          Positioned(
            bottom: 0,
            child: TotalPayButton()
          )
        ],
      ),
    );
  }
}