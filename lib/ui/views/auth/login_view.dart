import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/ui/components/custom_input.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/auth/login_label.dart';

class LoginView extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Form(),
                LoginLabel(),
                Text('Terminos y condiciones')
              ],
            ),
          )
        )
      )
    );
  }
}

class _Form extends StatefulWidget {
  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.email_outlined,
            placeHolder: 'usuario',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_open_outlined,
            placeHolder: 'contraseña',
            textController: passController,
            isPassword: true,
          ),

          RaisedButton(
            elevation: 2,
            highlightElevation: 5,
            color: Colors.blue,
            shape: StadiumBorder(),
            onPressed: authService.loging ? null : () async {
              FocusScope.of(context).unfocus();

              final loginResponse = await authService.login(emailController.text.trim(), passController.text.trim());

              if (loginResponse) {
                Navigator.pushReplacementNamed(context, 'home');
              } else {
                showAlert(context, 'login', 'Datos incorrectos');
              }
            },
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text('Ingresar', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
          )
        ]
      )
    );
  }
}