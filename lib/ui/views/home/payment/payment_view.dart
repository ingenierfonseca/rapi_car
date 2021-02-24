import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/core/services/stripe_service.dart';
import 'package:rapi_car_app/data/tarjetas.dart';
import 'package:rapi_car_app/ui/bloc/payment/payment_bloc.dart';
import 'package:rapi_car_app/ui/components/total_pay_button.dart';
import 'package:rapi_car_app/ui/views/home/payment/target_view.dart';

class PaymentView extends StatefulWidget {
  PaymentView({Key key}) : super(key: key);

  @override
  _PaymentViewState createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  PaymentBloc _paymentBloc;
  @override
  void initState() {
    _paymentBloc = context.bloc<PaymentBloc>();
    _paymentBloc.add(OnDisabledCard());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0xff21232a),
      appBar: AppBar(
        backgroundColor: Color(0xff384879),
        title: Text('Realizar Pago de Reserva'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () async {
            //showLoading(context);

            final stripeService = StripeService();
            final resp = await stripeService.payNewCard(amount: _paymentBloc.state.amuntString, currency: _paymentBloc.state.currency);
            //Navigator.pop(context);
          })
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            width: size.width,
            height: size.height,
            top: 200,
            child: PageView.builder(
              controller: PageController(
                viewportFraction: 0.9
              ),
              physics: BouncingScrollPhysics(),
              itemCount: tarjetas.length,
              itemBuilder: (_, i) {
                final tarjeta = tarjetas[i];

                return GestureDetector(
                  onTap: () {
                    context.bloc<PaymentBloc>().add(OnSelectedCard(tarjeta));
                    context.push(page: TargetView());
                  },
                  child: Hero(
                    tag: tarjeta.cardNumber,
                    child: CreditCardWidget(
                      cardNumber: tarjeta.cardNumber,
                      expiryDate: tarjeta.expiracyDate,
                      cardHolderName: tarjeta.cardHolderName,
                      cvvCode: tarjeta.cvv,
                      showBackView: false
                    )
                  )
                );
              }
            )
          ),

          Positioned(
            bottom: 0,
            child: TotalPayButton(),
          )
         ],
       )
    );
  }
}