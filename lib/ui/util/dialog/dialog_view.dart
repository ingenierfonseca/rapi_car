//import 'package:fimber/fimber.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_car_app/ui/util/dialog/dialog_service.dart';
import 'package:rapi_car_app/di/locator.dart';
//import 'package:rapi_car_app/r.g.dart';
import 'package:rapi_car_app/ui/res/colors.dart';
import 'package:rapi_car_app/ui/res/dimens.dart';
//import 'package:rapi_car_app/ui/res/text_styles.dart';
import 'package:rapi_car_app/core/providers/context_exts.dart';
import 'package:rapi_car_app/ui/util/dialog/dialog_interface.dart';
import 'package:rapi_car_app/ui/util/item.dart';
import 'package:rapi_car_app/ui/util/screen_util.dart';

class DialogView extends StatefulWidget {
  final Widget child;

  DialogView({Key key, this.child}) : super(key: key);

  @override
  _DialogViewState createState() => _DialogViewState();
}

class _DialogViewState extends State<DialogView> implements DialogInterface {
  final DialogService _dialogService = locator<DialogService>();

  bool _isShowing = false;

  @override
  void initState() {
    super.initState();
    _dialogService.registerListener(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  Future<bool> showAlertDialog({
    AssetImage iconTitle,
    String title,
    String message,
    String positiveText,
    String negativeText,
    Function(BuildContext context) postiveAction,
    Function(BuildContext context) negativeAction,
  }) async {
    dismissDialog();
    _isShowing = true;

    return (await showCupertinoDialog<bool>(
          context: context,
          builder: (BuildContext context) => CupertinoAlertDialog(
            insetAnimationCurve: Curves.bounceIn,
            title: Wrap(
              alignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                iconTitle != null
                    ? Image(
                        image: iconTitle,
                        width: 30.0.sw(),
                        height: 30.0.sw(),
                      )
                    : emptySpace(),
                iconTitle != null ? halfHorizontalSpace() : emptySpace(),
                Text(
                  title ?? 'RapiCar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    letterSpacing: -0.32,
                    fontSize: 17.0.sf(),
                    fontWeight: FontWeight.w600,
                    //fontFamily: R.fontFamily.sFProDisplay,
                  ),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  normalVerticalSpace(),
                  Text(
                    message,
                    style: TextStyle(
                      color: Colors.black,
                      letterSpacing: -0.8,
                      fontSize: 16.0.sf(),
                      fontWeight: FontWeight.w500,
                      //fontFamily: R.fontFamily.avenirNextLTPro,
                    ),
                  ),
                ],
              ),
            ),
            actions: _buildButtonsDialog(
              positiveText: positiveText,
              postiveAction: postiveAction,
              negativeText: negativeText,
              negativeAction: negativeAction,
            ),
          ),
        )) ??
        false;
  }

  List<Widget> _buildButtonsDialog({
    String positiveText,
    String negativeText,
    Function postiveAction,
    Function negativeAction,
  }) {
    var listButtons = <Widget>[];
    if (negativeAction != null || negativeText != null) {
      listButtons.add(
        CupertinoDialogAction(
          isDestructiveAction: true,
          child: Text(
            negativeText ?? 'Salir',
            style: TextStyle(
              color: kAccentColor,
              letterSpacing: -0.24,
              fontSize: 17.0.sf(),
              fontWeight: FontWeight.w600,
              //fontFamily: R.fontFamily.sFProDisplay,
            ),
          ),
          onPressed: () {
            if (negativeAction != null) negativeAction(context);
            dismissDialog();
          },
        ),
      );
    }

    listButtons.add(
      CupertinoDialogAction(
        isDefaultAction: true,
        child: Text(
          positiveText ?? 'Entendido',
          style: TextStyle(
            color: kPrimaryColor,
            letterSpacing: -0.24,
            fontSize: 17.0.sf(),
            fontWeight: FontWeight.w600,
            //fontFamily: R.fontFamily.sFProDisplay,
          ),
        ),
        onPressed: () {
          if (postiveAction != null) postiveAction(context);
          dismissDialog();
        },
      ),
    );
    return listButtons;
  }

  @override
  Future<void> showLoadingDialog() async {
    dismissDialog();
    _isShowing = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Material(
          color: Colors.black26,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  @override
  Future<void> showListViewDialog({
    String title,
    List<Item> listItem,
    Function(Item item) onChoosedItem,
  }) async {
    dismissDialog();
    _isShowing = true;
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title/*, style: titleStyle().textColor(Colors.black)*/),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: 42.0 * listItem.length,
            child: ListView(
              children: listItem
                  .map(
                    (item) => CupertinoButton(
                      padding: EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              item.getTitle(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.start,
                              //style: body1Style().textColor(Colors.black),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        dismissDialog();
                        onChoosedItem(item);
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        );
      },
    );
  }

  @override
  void dismissDialog() {
    if (_isShowing) {
      _isShowing = false;
      try {
        context.popView();
      } catch (e) {
        //Fimber.e('Error ocultando alertar', ex: e);
      }
    }
  }
}