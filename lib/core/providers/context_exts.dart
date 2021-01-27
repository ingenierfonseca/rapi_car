import 'package:flutter/material.dart';

extension ContextExts on BuildContext {
  void popView() => Navigator.pop(this);

  void pushView({String view, dynamic argument}) =>
      Navigator.pushNamed(this, view, arguments: argument);

  void pushReplacementView({String view, dynamic argument}) =>
      Navigator.pushReplacementNamed(this, view, arguments: argument);

  void popPostView() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pop(this);
    });
  }

  void pushPostView({String view, dynamic argument}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushNamed(this, view, arguments: argument);
    });
  }

  void pushReplacementPostView({String view, dynamic argument}) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Navigator.pushReplacementNamed(this, view, arguments: argument);
    });
  }

  Object arguments() => ModalRoute.of(this).settings.arguments;
}