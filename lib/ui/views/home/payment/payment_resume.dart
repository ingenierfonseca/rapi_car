import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/services/payment_service.dart';
import 'package:rapi_car_app/ui/components/car_widget.dart';
import 'package:rapi_car_app/ui/components/login_view_widget.dart';
import 'package:rapi_car_app/ui/util/decoration_util.dart';

import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/ui/views/home/payment/payment_completed_completed.dart';
import 'package:rapi_car_app/ui/views/home/payment/payment_loading.dart';

class PaymentResume extends StatefulWidget {
  PaymentResume({Key key}) : super(key: key);

  @override
  _PaymentResumeState createState() => _PaymentResumeState();
}

class _PaymentResumeState extends State<PaymentResume> {
  Car _car;
  bool ispayment = false;

  @override
  void initState() {
    super.initState();
    _car = context.getArguments();
  }

  @override
  Widget build(BuildContext context) {
    final paymentService = Provider.of<PaymentService>(context, listen: false);
    var priceDriveInclude = (paymentService.payment.driveInclude != null && paymentService.payment.driveInclude) ? 15 : 0;
    priceDriveInclude = priceDriveInclude * paymentService.payment.countDays;
    final total = _car.price * paymentService.payment.countDays/* + (paymentService.payment.driveInclude ? 15 : 0)*/;

    return Column(
      children: [
        Visibility(visible: !ispayment, child: SingleChildScrollView(
      child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            children: [
              Text('Detalle de Servicio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              rentCarDetailInfoResume(_car, paymentService.payment, priceDriveInclude.toDouble(), context),
              Container(
                height: 1,
                color: Colors.black,
              ),
              SizedBox(height: 30),
              Text('Total a Pagar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.grey),
              ),
              SizedBox(height: 10),
              Text('\$${total + priceDriveInclude}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 30),
              generateLargeButton(
                label: 'PAGAR', 
                callback: () async {
                  setState(() {
                    ispayment = true;
                  });
                  await Future.delayed(Duration(seconds: 5));
                  setState(() {
                    ispayment = false;
                  });
                  context.pushReplacement(page: PaymentCompletedView());
                }
              ),
              SizedBox(height: 10),
              Text('Al procesar el pago estas deacuerdo con las tarifas, terminos y condiciones asi como la politica de privacidad.')
            ]
          )
        ]
      )
    ))),_buildLoadingComponent()
      ]
    );
  }

  Widget _buildLoadingComponent() {
    return Visibility(visible: ispayment, child: PaymentLoading());
  }
}