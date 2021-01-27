import 'package:get_it/get_it.dart';
import 'package:rapi_car_app/core/services/user_service.dart';
import 'package:rapi_car_app/ui/util/dialog/dialog_service.dart';
import 'package:rapi_car_app/ui/viewmodels/car_view_model.dart';
import 'package:rapi_car_app/ui/viewmodels/payment_view_model.dart';

GetIt locator = GetIt.instance;

Future<void> setupLocator() async {

  //inyeccion de servicios lazy sigleton
  locator.registerLazySingleton(() => UserService());

  //inyeccion de view models
  locator.registerFactory(() => CarViewModel());
  locator.registerFactory(() => PaymentViewModel());

  //inyeccion de vistas
  locator.registerLazySingleton(() => DialogService());
}