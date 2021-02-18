import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';
import 'package:rapi_car_app/ui/views/home/car/filter_car_view.dart';

Widget generarCupertinoNavBar(BuildContext context/*, User user*/) {
  return CupertinoNavigationBar(
    backgroundColor: Colors.black,
    leading: generarOpenPicture(),
    //middle: generarMiddleIcon(context),
    trailing: generateFilterPicture(),//generarProfilePicture(),
    border: Border.all(color: Colors.transparent),
  );
}

//Menu Boton Para abrir el Drawer
Widget generarOpenPicture() {
  return Builder(
    builder: (ctx) {
      return CupertinoButton(
        padding: EdgeInsets.all(0.0),
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.sort, color: Colors.white),
        ),
        onPressed: () {
          if (Scaffold.of(ctx).isDrawerOpen) {
            Scaffold.of(ctx).openEndDrawer();
          } else {
            Scaffold.of(ctx).openDrawer();
          }
        },
      );
    },
  );
}

Widget generateFilterPicture() {
  return Builder(
    builder: (ctx) {
      return CupertinoButton(
        padding: EdgeInsets.all(0.0),
        child: Container(
          width: 24,
          height: 24,
          alignment: Alignment.center,
          padding: EdgeInsets.all(0.0),
          child: Icon(Icons.tune, color: Colors.white),
        ),
        onPressed: () {
          ctx.push(page: FilterCarView());
        },
      );
    },
  );
}