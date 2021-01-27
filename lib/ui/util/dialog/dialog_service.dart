import 'package:flutter/widgets.dart';
import 'package:rapi_car_app/ui/util/dialog/dialog_interface.dart';
import 'package:rapi_car_app/ui/util/item.dart';

class DialogService {
  DialogInterface _dialogInterface;

  void registerListener(DialogInterface dialogInterface) =>
      _dialogInterface = dialogInterface;

  Future<void> showPostAlertDialog({
    AssetImage iconTitle,
    String title,
    String message,
    String positiveText,
    String negativeText,
    Function postiveAction,
    Function negativeAction,
  }) async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await _dialogInterface.showAlertDialog(
        iconTitle: iconTitle,
        title: title,
        message: message,
        positiveText: positiveText,
        negativeText: negativeText,
        postiveAction: postiveAction,
        negativeAction: negativeAction,
      );
    });
  }

  Future<bool> showAlertDialog({
    AssetImage iconTitle,
    String title,
    String message,
    String positiveText,
    String negativeText,
    Function(BuildContext context) postiveAction,
    Function(BuildContext context) negativeAction,
  }) async {
    return await _dialogInterface.showAlertDialog(
      iconTitle: iconTitle,
      title: title,
      message: message,
      positiveText: positiveText,
      negativeText: negativeText,
      postiveAction: postiveAction,
      negativeAction: negativeAction,
    );
  }

  Future<void> showListViewDialog({
    String title,
    List<Item> listItem,
    Function(Item item) onChoosedItem,
  }) async {
    await _dialogInterface.showListViewDialog(
      title: title,
      listItem: listItem,
      onChoosedItem: onChoosedItem,
    );
  }

  Future<bool> showComingSoonDialog({Function postiveAction}) async {
    return await _dialogInterface.showAlertDialog(
      title: 'Próximamente',
      message: 'Seguimos trabajando.',
      postiveAction: postiveAction,
    );
  }

  Future<void> showLoadingDialog() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _dialogInterface.showLoadingDialog();
    });
  }

  void dismissDialog() => _dialogInterface.dismissDialog();
}