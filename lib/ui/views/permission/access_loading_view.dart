import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rapi_car_app/ui/util/helpers/helpers.dart';
import 'package:rapi_car_app/ui/views/home/dashboard_pages/filter_map_view.dart';
import 'package:rapi_car_app/ui/views/permission/access_gps_view.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';

class AccessLoadingView extends StatelessWidget {
  const AccessLoadingView({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Center(
            child: CircularProgressIndicator(strokeWidth: 2),
          );
        }
      )
    );
  }

  Future checkGpsLocation(BuildContext context) async {
    final permissionGps = await Permission.location.isGranted;
    final gpsIsActive = await Geolocator.isLocationServiceEnabled();

    if (permissionGps && gpsIsActive) {
      //Navigator.pushReplacement(context, navFadeIn(context, FilterMapView()));
      context.push(page: FilterMapView(), arguments: LatLng(12.128264, -86.264012));
    } else if (!permissionGps) {
      context.push(page: AccessGpsView());
    } else {

    }
  }
}