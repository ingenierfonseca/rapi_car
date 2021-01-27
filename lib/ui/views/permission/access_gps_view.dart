import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rapi_car_app/ui/views/home/dashboard_pages/filter_map_view.dart';
import 'package:latlong/latlong.dart';

import 'package:rapi_car_app/core/providers/app_page_manager.dart';

class AccessGpsView extends StatefulWidget {
  AccessGpsView({Key key}) : super(key: key);

  @override
  _AccessGpsViewState createState() => _AccessGpsViewState();
}

class _AccessGpsViewState extends State<AccessGpsView> with WidgetsBindingObserver {

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if ( state == AppLifecycleState.resumed) {
      if (await Permission.location.isGranted) {
        context.push(page: FilterMapView(), arguments: LatLng(12.128264, -86.264012));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Es necesario el GPS para usar esta app'),

            MaterialButton(
              child: Text('Solicitar Acceso', style: TextStyle(color: Colors.white)),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () async {
                final statusPermissionGps = await Permission.location.request();
                this._accessGPS(statusPermissionGps);
              }
            )
          ],
        ),
      ),
    );
  }

  void _accessGPS(PermissionStatus status) {

    switch(status) {
      case PermissionStatus.granted:
      //TODO:
      break;
      case PermissionStatus.denied:
      case PermissionStatus.permanentlyDenied:
      case PermissionStatus.restricted:
       openAppSettings();
      break;
    }
  }
}