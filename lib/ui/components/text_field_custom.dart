import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  //final IconData icon;
  final String placeHolder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  const TextFieldCustom({
    Key key,
    //@required this.icon,
    @required this.placeHolder,
    @required this.textController,
    this.keyboardType = TextInputType.text,
    this.isPassword = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
        filled: true,
        labelText: placeHolder,
        labelStyle: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
        hintStyle: TextStyle(fontSize: 12),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.pinkAccent,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: Colors.grey[300],
            width: 1.5,
          ),
        )
      ),
      controller: textController,
    );
  }
}