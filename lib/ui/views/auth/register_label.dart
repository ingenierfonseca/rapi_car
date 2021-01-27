import 'package:flutter/material.dart';

class RegisterLabel extends StatelessWidget {
  const RegisterLabel({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Ya tienes cuenta?', style: TextStyle(color: Colors.black54)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'login'),
            child: Text('Ingresa ahora!', style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold))
          )
        ],
      ),
    );
  }
}