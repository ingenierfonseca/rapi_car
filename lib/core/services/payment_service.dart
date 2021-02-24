import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/models/payment.dart';
import 'package:rapi_car_app/core/services/app_service.dart';

class PaymentService with ChangeNotifier, AppService {
  Payment payment = null;
}