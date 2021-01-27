import 'package:flutter/material.dart';

class ScreenUtil {
  static double _screenWidth;
  static double _screenHeight;
  static double _textScaleFactor;

  static void init(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);
    _screenWidth = mediaQuery.size.width;
    _screenHeight = mediaQuery.size.height;
    _textScaleFactor = mediaQuery.textScaleFactor;
  }

  static double scaleWidth(double width) {
    var scaleWidth = _screenWidth * ((width / 100) / 3.9272727272727273);
    return scaleWidth.roundToDouble();
  }

  static double scaleHeight(double height) {
    var scaleHeight = _screenHeight * ((height / 100) / 8.1672727272727273);
    return scaleHeight.roundToDouble();
  }

  static double scaleFont(double fontSize) {
    var scaleFont =
        (fontSize * (_screenWidth / 812)) / _textScaleFactor * 1.77812971;
    return scaleFont.roundToDouble();
  }
}

extension SizeScale on double {
  double sw() => ScreenUtil.scaleWidth(this);

  double sh() => ScreenUtil.scaleHeight(this);

  double sf() => ScreenUtil.scaleFont(this);
}