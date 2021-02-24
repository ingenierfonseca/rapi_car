import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapi_car_app/core/services/payment_service.dart';
import 'package:rapi_car_app/ui/components/login_view_widget.dart';
import 'package:rapi_car_app/ui/util/decoration_util.dart';
import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:provider/provider.dart';

class PaymentMethod extends StatefulWidget {
  PaymentMethod({Key key}) : super(key: key);

  @override
  _PaymentMethodState createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  int groupMethod = 0;
  int valueCreditCar = 1;
  int valueGAPay = 2;

  @override
  void initState() {
    super.initState();
    final paymentService = Provider.of<PaymentService>(context, listen: false);
    if (paymentService.payment.typeMethod != null) {
      groupMethod = int.parse(paymentService.payment.typeMethod);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: containerDecoration,
      child: Column(
        children: [
          Text('Método de pago', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 30),
          _itemCreditCardPay('Tarjeta de crédito'),
          _itemGoogleOrApplePay('Google pay'),
          SizedBox(height: 30),
          generateButton(
            label: 'Acepter', 
            callback: () {
              final paymentService = Provider.of<PaymentService>(context, listen: false);
              paymentService.payment.typeMethod = groupMethod.toString();
              context.pop();
            }
          )
        ],
      )
    );
  }

  Widget _itemCreditCardPay(String label) {
    return Row(
      children: [
        Radio(
          value: valueCreditCar,
          groupValue: groupMethod,
          onChanged: (v) {
            setState(() {
              groupMethod = v;
            });
          }
        ),
        Text(label),
        SizedBox(width: 10),
        Image( 
          width: 30,
          height: 30,
          image: R.svg.master_card(width: 30, height: 30)
        ),
        Image( 
          width: 30,
          height: 30,
          image: R.svg.visa_card(width: 30, height: 30)
        )
      ],
    );
  }//FontAwesomeIcons.google

  Widget _itemGoogleOrApplePay(String label) {
    return Row(
      children: [
        Radio(
          value: valueGAPay,
          groupValue: groupMethod,
          onChanged: (v) {
            setState(() {
              groupMethod = v;
            });
          }
        ),
        Text(label),
        SizedBox(width: 10),
        Icon(
          Platform.isAndroid ? 
          FontAwesomeIcons.google : 
          FontAwesomeIcons.apple, 
          size: 20
        )
      ],
    );
  }
}