import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:rapi_car_app/ui/util/item.dart';

abstract class DialogInterface {
  Future<bool> showAlertDialog({
    AssetImage iconTitle,
    String title,
    String message,
    String positiveText,
    String negativeText,
    Function(BuildContext context) postiveAction,
    Function(BuildContext context) negativeAction,
  });

  Future<void> showListViewDialog({
    String title,
    List<Item> listItem,
    Function(Item data) onChoosedItem,
  });

  Future<void> showLoadingDialog();

  void dismissDialog();
}