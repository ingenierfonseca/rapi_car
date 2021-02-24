import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/res/colors.dart';

final  containerDecoration = BoxDecoration(
    color: CupertinoColors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(20.0)
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.biccosGrayColorShadow.withOpacity(0.3),//Colors.grey.withOpacity(0.3),
        spreadRadius: 4,
        blurRadius: 5,
        offset: Offset(0, 2), // changes position of shadow
      ),
    ]
);

final  containerDecorationTransfer = BoxDecoration(
    color: CupertinoColors.white,
    borderRadius: BorderRadius.all(
      Radius.circular(5.0)
    ),
    boxShadow: [
      BoxShadow(
        color: AppColors.biccosGrayColorShadow.withOpacity(0.3),
        spreadRadius: 4,
        blurRadius: 5,
        offset: Offset(0, 2),
      ),
    ]
);