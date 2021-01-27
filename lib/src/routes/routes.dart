import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/views/loading_view.dart';
import 'package:rapi_car_app/ui/views/auth/login_view.dart';
import 'package:rapi_car_app/ui/views/auth/register_view.dart';
import 'package:rapi_car_app/ui/views/home/car/car_detail.dart';
import 'package:rapi_car_app/ui/views/home/car/add_image_item_view.dart';
import 'package:rapi_car_app/ui/views/home/dashboard_pages/filter_map_view.dart';
import 'package:rapi_car_app/ui/views/home/home_view.dart';

Route<dynamic> generateRoutes(RouteSettings settings) {
  switch(settings.name) {
    //case Wrapper.id:
      //return MaterialPageRoute(builder: (context) => Wrapper());
    case LoadingView.id:
      return MaterialPageRoute(
        builder: (context) => LoadingView(), settings: settings);
    case LoginView.id:
      return MaterialPageRoute(
        builder: (context) => LoginView(), settings: settings);
    case RegisterView.id:
      return MaterialPageRoute(
        builder: (context) => RegisterView(), settings: settings);
    case HomeView.id:
      return MaterialPageRoute(
        builder: (context) => HomeView(), settings: settings);
    case FilterMapView.id:
      return MaterialPageRoute(
        builder: (context) => FilterMapView(), settings: settings);
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No se ha establecido una ruta para ${settings.name}'),
          ),
        ),
      );
  }
  /*return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomeView(),
    //'car_detail': (BuildContext context) => CarDetail(),
    'car_register': (BuildContext context) => RegisterCar(),
    'add_image_item': (BuildContext context) => AddImageItemPage(),
    'map_location': (BuildContext context) => MapPage()
  }; */
}