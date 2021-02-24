import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rapi_car_app/core/models/car.dart';
import 'package:rapi_car_app/core/services/payment_service.dart';
import 'package:rapi_car_app/ui/components/car_widget.dart';
import 'package:rapi_car_app/ui/components/login_view_widget.dart';
import 'package:rapi_car_app/ui/util/decoration_util.dart';

import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/home/payment/payment_method.dart';

import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/ui/views/home/payment/payment_resume.dart';

class PaymentForm extends StatefulWidget {
  PaymentForm({Key key}) : super(key: key);

  @override
  _PaymentFormState createState() => _PaymentFormState();
}

class _PaymentFormState extends State<PaymentForm> {
  Car _car;
  final daysController = TextEditingController();
  bool driveValue = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final paymentService = Provider.of<PaymentService>(context, listen: false);

    _car = context.getArguments();

    daysController.text = paymentService.payment.countDays != null ? paymentService.payment.countDays.toString() : '';
    driveValue = paymentService.payment.driveInclude != null ? paymentService.payment.driveInclude : false;
    daysController.addListener(() {
      paymentService.payment.countDays = int.parse(daysController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    final paymentService = Provider.of<PaymentService>(context, listen: false);

    return SingleChildScrollView(
      child: Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: containerDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  Text('Detalle de Servicio', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  rentCarDetailInfo(_car, context),
                  Container(
                    height: 1,
                    color: Colors.black,
                  ),
                  SizedBox(height: 30),
                  Text('Complete la siguiente información', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  generateImput(label: 'Cantidad de días', textInputType: TextInputType.number, controller: daysController, validator: true),
                  ListTile(
                    title: Text('Incluir Chofer'),
                    trailing: Checkbox(
                      value: driveValue,
                      onChanged: (T) async {
                        setState(() {
                          driveValue = !driveValue;
                          paymentService.payment.driveInclude = driveValue;
                        });
                      }
                    )
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Método de pago'),
                        FlatButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          onPressed: () => {
                            context.push(page: PaymentMethod())
                          },
                          color: Colors.grey[300],
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              SizedBox(width: 10),
                              paymentService.payment.typeMethod != null ?
                              Row(
                                children: paymentService.payment.typeMethod == '1' ? [
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
                                ] : [
                                  Icon(
                                    Platform.isAndroid ? 
                                    FontAwesomeIcons.google : 
                                    FontAwesomeIcons.apple, 
                                    size: 20
                                  )
                                ]
                              ) :
                              Text("Seleccionar"),
                              Icon(Icons.keyboard_arrow_right),
                            ],
                          )
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  generateLargeButton(
                    label: 'CONTINUAR', 
                    callback: () {
                      if (_formKey.currentState.validate()) {
                        if (paymentService.payment.typeMethod == null || paymentService.payment.typeMethod == '0') {
                          showAlert(context, 'title', 'No ha seleccionado un metodo de pago');
                          return;
                        }
                        context.push(page: PaymentResume(), arguments: _car);
                      }
                    }
                  )
                ]
              )
          )
          //generateImput(label: 'Email', textInputType: TextInputType.emailAddress, controller: emailController, validator: true),
        ]
      )
    ));
  }
}