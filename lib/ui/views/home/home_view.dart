import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/providers/payment_provider.dart';
import 'package:rapi_car_app/core/providers/context_exts.dart';
import 'package:rapi_car_app/core/services/car_service.dart';
import 'package:rapi_car_app/ui/components/app_pages.dart';
import 'package:rapi_car_app/ui/components/drawer_app.dart';
import 'package:rapi_car_app/ui/components/main_view_widgets.dart' as main_components;

import 'package:provider/provider.dart';
import 'package:rapi_car_app/ui/views/home/dashboard_pages/dashboard_app.dart';

class HomeView extends StatefulWidget {
  static const String id = 'home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  String argument = '';
  Widget page;

  @override
  Widget build(BuildContext context) {
    argument = (context.arguments() is String) ? context.arguments() : '';
    page = (context.arguments() is Widget)
        ? context.arguments()
        : DashboardApp();

    return _generateScaffold();
  }

  Widget _generateScaffold() {
    return ChangeNotifierProvider(
        create: (context) => PaymentProvider(),
        builder: (context, child) {
          return AppPages(
            onWillPop: _onWillPop,
            drawer: DrawerApp(),
            appBar: main_components.generarCupertinoNavBar(context),
            body: page,
            arguments: argument,
          );
        });
  }

  Future<bool> _onWillPop() async {
    return (await showCupertinoDialog(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            insetAnimationCurve: Curves.bounceIn,
            title: Text('Salir de RapiCar'),
            content: Text('\n¿Estas seguro que deseas salir de la aplicación?'),
            actions: [
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('No'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Si'),
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          ),
        )) ??
        false;
  }
}