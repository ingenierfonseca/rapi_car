import 'package:flutter/material.dart';

class LoginLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('No tienes cuenta?', style: TextStyle(color: Colors.black54)),
          SizedBox(height: 10),
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'register'),
            child: Text('Crear una cuenta ahora!', style: TextStyle(color: Colors.blue[400], fontWeight: FontWeight.bold))
          )
        ],
      ),
    );
  }
}