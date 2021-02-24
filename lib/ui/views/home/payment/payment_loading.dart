import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/components/loading_animation.dart';

class PaymentLoading extends StatefulWidget {
  @override
  _PaymentLoadingState createState() => _PaymentLoadingState();
}

class _PaymentLoadingState extends State<PaymentLoading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 100),
      margin: EdgeInsets.only(left: 15, right: 15, bottom: 20, top: 20),
      child: Column(
        children: <Widget>[
          SizedBox(height: 50),
          //Image(image: R.image.ic_biccos()),
          SizedBox(height: 20),
          Text('ESTAMOS PROCESANDO TU SOLICITUD'),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [LoadingAnimation(color: Colors.red)],
            ),
          ),
        ],
      ),
    );
  }
}