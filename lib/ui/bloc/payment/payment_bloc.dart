import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rapi_car_app/src/models/credit_card_custom.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  PaymentBloc() : super(PaymentState());

  @override
  Stream<PaymentState> mapEventToState(PaymentEvent event) async* {
    switch(event.runtimeType) {
      case OnSelectedCard:
        yield state.copyWith(targetIsActive: true, creditCard: (event as OnSelectedCard).card);
      break;
      case OnDisabledCard:
        yield state.copyWith(targetIsActive: false, creditCard: null);
      break;
    }
  }
}
