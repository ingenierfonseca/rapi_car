import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/ui/views/home/home_view.dart';

class LoadingView extends StatelessWidget {
  static const String id = 'loading';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Espere...'),
          );
        },
      ),
    );
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);

    final logged = await authService.isLoggedIn();

    if (logged) {
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => HomeView(),
          transitionDuration: Duration(microseconds: 0)
        )
      );
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}