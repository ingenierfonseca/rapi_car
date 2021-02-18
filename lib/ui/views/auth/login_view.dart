import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rapi_car_app/core/services/auth_service.dart';
import 'package:rapi_car_app/ui/components/custom_input.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/auth/login_label.dart';
import 'package:rapi_car_app/ui/views/auth/logo_view.dart';

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
          //physics: BouncingScrollPhysics(),
          child: Container(
            //height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LogoView(),
                _Form(),
                //LoginLabel(),
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
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Ingresar", style: TextStyle(color: Color.fromRGBO(49, 39, 79, 1), fontWeight: FontWeight.bold, fontSize: 30)),
          SizedBox(height: 30,),
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
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(top:10, bottom: 10, right: 10, left: 20),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              color: Colors.grey[200]
                            ))
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Usuario",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            controller: emailController,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top:10, bottom: 10, right: 10, left: 20),
                          child: TextField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Contraseña",
                              hintStyle: TextStyle(color: Colors.grey)
                            ),
                            controller: passController,
                            obscureText: true,
                          ),
                        )
                      ],
                    ),
                  ),
          SizedBox(height: 20,),
          Center(child: Text("Olvidaste tu contraseña?", style: TextStyle(color: Color.fromRGBO(196, 135, 198, 1)),)),
          SizedBox(height: 30),
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(horizontal: 60),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Color.fromRGBO(49, 39, 79, 1),
            ),
            child: GestureDetector(
              onTap: authService.loging ? null : () async {
                FocusScope.of(context).unfocus();

                final loginResponse = await authService.login(emailController.text.trim(), passController.text.trim());

                if (loginResponse) {
                  Navigator.pushReplacementNamed(context, 'home');
                } else {
                  showAlert(context, 'login', 'Datos incorrectos');
                }
              },
              child: Center(
                child: Text("Ingresar", style: TextStyle(color: Colors.white),),
              )
            ),
          ),
          SizedBox(height: 30),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'register'),
            child: Center(child: Text("Crear Cuenta", style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),))
          )
        ]
      )
    );
  }
}