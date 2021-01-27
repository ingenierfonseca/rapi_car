import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/providers/payment_provider.dart';
import 'package:rapi_car_app/core/providers/context_exts.dart';
import 'package:rapi_car_app/ui/components/app_pages.dart';
import 'package:rapi_car_app/ui/components/drawer_app.dart';
import 'package:rapi_car_app/ui/viewmodels/user_view_model.dart';

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
  Timer _timer, _timerOut;

  @override
  void initState() {
    super.initState();
    _initTimer();
  }

  void _initTimer() {
    _timerOut?.cancel();
    _timerOut = null;

    _timer?.cancel();

    _timer = Timer(const Duration(minutes: 5), () => _askForMoreTime());
  }

  void _askForMoreTime() async {
    _timer?.cancel();
    _timer = null;

    if (_timerOut != null) {
      _timerOut.cancel();
    }
    _timerOut = Timer(const Duration(minutes: 1), () {
      UserViewModel().logout();
      //locator<DialogService>().dismissDialog();
      //context.pushReplacementView(view: LoginView.id);
    });

    /*await locator<DialogService>().showAlertDialog(
      title: 'Tu tiempo de sesión va expirar',
      message: '¿Necesitas mas tiempo?',
      positiveText: 'Continuar',
      postiveAction: (context) {
        _initTimer();
      },
      negativeText: 'Salir',
      negativeAction: (ctx) async {
        UserViewModel().logout();
        context.pushReplacementView(view: LoginView.id);
      },
    );*/
  }

  void _handleUserInteraction([_]) {
    if (!_timer.isActive) {
      return;
    }
    _timer?.cancel();
    _initTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _timerOut?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    argument = (context.arguments() is String) ? context.arguments() : '';
    page = (context.arguments() is Widget)
        ? context.arguments()
        : DashboardApp();

    return GestureDetector(
      onTap: _handleUserInteraction,
      onPanDown: _handleUserInteraction,
      child: _generateScaffold(),
    );
  }

  Widget _generateScaffold() {
    return ChangeNotifierProvider(
        create: (context) => PaymentProvider(),
        builder: (context, child) {
          return AppPages(
            onWillPop: _onWillPop,
            drawer: DrawerApp(),
            //appBar: NoAppBar(),
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