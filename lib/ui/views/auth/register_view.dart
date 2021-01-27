import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/ui/components/custom_input.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
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
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Form(),
                RegisterLabel(),
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
  final nameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final passConfirmationController = TextEditingController();


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
            placeHolder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameController,
          ),
          CustomInput(
            icon: Icons.email_outlined,
            placeHolder: 'Apellido',
            keyboardType: TextInputType.text,
            textController: lastNameController,
          ),
          CustomInput(
            icon: Icons.email_outlined,
            placeHolder: 'email',
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_open_outlined,
            placeHolder: 'contraseña',
            textController: passController,
            isPassword: true,
          ),
          CustomInput(
            icon: Icons.lock_open_outlined,
            placeHolder: 'confirmar contraseña',
            textController: passConfirmationController,
            isPassword: true,
          ),

          RaisedButton(
            elevation: 2,
            highlightElevation: 5,
            color: Colors.blue,
            shape: StadiumBorder(),
            onPressed: authService.loging ? null : () async {
              FocusScope.of(context).unfocus();

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
            },
            child: Container(
              width: double.infinity,
              child: Center(
                child: Text('Registrar', style: TextStyle(color: Colors.white, fontSize: 18),),
              ),
            ),
          )
        ]
      )
    );
  }
}