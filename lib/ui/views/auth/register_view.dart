import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/ui/components/custom_input.dart';
import 'package:rapi_car_app/ui/components/login_view_widget.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/auth/logo_view.dart';
import 'package:rapi_car_app/ui/views/auth/register_label.dart';

class RegisterView extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          //physics: BouncingScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoView(),
                _Form(),
                //RegisterLabel(),
                //Text('Terminos y condiciones')
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
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmationController = TextEditingController();

  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Registrarse", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30)),
          SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Color.fromRGBO(196, 135, 198, .3),
                  blurRadius: 20,
                  offset: Offset(0, 10),
                )
              ]
            ),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Column(
                children: [
                  generateImput(label: 'Nombre', controller: nameController, validator: true),
                  generateImput(label: 'Apellido', controller: lastNameController, validator: true),
                  generateImput(label: 'Email', textInputType: TextInputType.emailAddress, controller: emailController, validator: true),
                  generateImput(label: 'Contraseña', textInputType: TextInputType.text, controller: passController, obscureText: true, validator: true),
                  generateImput(label: 'Confirmar Contraseña', textInputType: TextInputType.text, controller: passConfirmationController, obscureText: true, validator: true)
                ]
              )
            )
          ),
          SizedBox(height: 30),
          generateButton(
            label: 'Registrar', 
            callback: authService.loging ? (){} : () async {
              FocusScope.of(context).unfocus();

              if (_formKey.currentState.validate()) {
                final loginResponse = await authService.register(
                  nameController.text.trim(),
                  lastNameController.text.trim(),
                  emailController.text.trim(), 
                  passController.text.trim(),
                  passConfirmationController.text.trim()
                );

                if (loginResponse == true) {
                  Navigator.pushReplacementNamed(context, 'login');
                } else {
                  showAlert(context, 'Registro', loginResponse);
                }
              }
            }
          ),
          SizedBox(height: 20),
           Center(child: Text("Ya tienes cuenta?", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)))),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'login'),
            child: Center(child: Text("Ingresa Ahora!", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),))
          ),
          SizedBox(height: 40)
        ]
      )
    );
  }
}