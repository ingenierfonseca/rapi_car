import 'package:flutter/material.dart';

Widget generateImput({
  String label,
  TextInputType textInputType = TextInputType.text,
  TextEditingController controller,
  bool obscureText = false,
  bool validator = false
  }) {
  return Container(
    padding: EdgeInsets.only(top:10, bottom: 10, right: 10, left: 20),
    decoration: BoxDecoration(
      border: Border(bottom: BorderSide(
      color: Colors.grey[200]
    ))
    ),
    child: TextFormField(
      validator: (value) {
        if (validator && value.isEmpty) {
          return 'El campo $label es requerido';
        }
        return null;
      },
      obscureText: obscureText,
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: label,
      hintStyle: TextStyle(color: Colors.grey),
    ),
    keyboardType: textInputType,
    controller: controller,
  ));
}

Widget generateButton({String label, VoidCallback callback}) {
  return Container(
    height: 50,
    margin: EdgeInsets.symmetric(horizontal: 60),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(50),
      color: Color.fromRGBO(49, 39, 79, 1),
    ),
    child: GestureDetector(
      onTap: callback,
      child: Center(
        child: Text(label, style: TextStyle(color: Colors.white)),
      )
    ),
  );
}