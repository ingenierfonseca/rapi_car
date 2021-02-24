import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapi_car_app/ui/components/login_view_widget.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';

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
            Text('Gracias por usar RapiCar :)'),
            SizedBox(height: 30),
            generateButton(label: 'Aceptar', callback: () {
              Navigator.pushReplacementNamed(context, 'home');
            })
          ],
        ),
      ),
    );
  }
}