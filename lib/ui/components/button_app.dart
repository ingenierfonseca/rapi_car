import 'package:flutter/material.dart';

class ButtonApp extends StatelessWidget {
  final String text;
  final VoidCallback callback;
  final bool isActive;

  ButtonApp({@required this.text, @required this.callback, this.isActive = true});

  @override
  Widget build(BuildContext context) {
    final _screenSize =   MediaQuery.of(context).size;

    return Center(child:Container(
      width: _screenSize.width * 0.85,
      height: 35,
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        color: this.isActive ? Colors.pinkAccent : Colors.grey[300],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: InkWell(
          splashColor: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 3,
                fontSize: 14,
                //fontWeight: FontWeight.bold,
                //fontFamily: R.fontFamily.sFProDisplay,
              ),
            )
          ),
          onTap: callback,
        ),
      ),
    ));
  }
}