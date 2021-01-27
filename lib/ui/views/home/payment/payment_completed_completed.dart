import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PaymentCompletedView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(FontAwesomeIcons.check, size: 70, color: Colors.green),
            Text('Pago realizado exitosamente!'),
            Text('Gracias por usar RapiCar :)')
          ],
        ),
      ),
    );
  }
}