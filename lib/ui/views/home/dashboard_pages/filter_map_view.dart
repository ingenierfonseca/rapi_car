import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_map/flutter_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:latlong/latlong.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rapi_car_app/ui/bloc/map/map_bloc.dart';
import 'package:rapi_car_app/ui/bloc/my_location/my_location_bloc.dart';
import '../../../../r.g.dart';
import 'package:rapi_car_app/core/providers/app_page_manager.dart';

class FilterMapView extends StatefulWidget {
  static const String id = 'filter_map';

  @override
  _FilterMapViewState createState() => _FilterMapViewState();
}

class _FilterMapViewState extends State<FilterMapView> {
  //static const String ACCESS_TOKEN = 'pk.eyJ1IjoiaW5nZW5pZXJmb25zZWNhIiwiYSI6ImNrZ2lqYWxtMzFsbWIyeHBkMTE1ZjF4NzEifQ.3seMzzMDNXqR2fyvn4izXw';
  LatLng latLng;
  double radio = 5000;
  Set<Circle> _circles = HashSet<Circle>();

  @override
  void initState() {
    context.read<MyLocationBloc>().startTracking();
    super.initState();
    latLng = context.getArguments();
    _setCricleMarker(latLng);
  }

  @override
  void dispose() {
    context.read<MyLocationBloc>().finishTracking();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      /*appBar: AppBar(
        title: Text('Ubicación'),
        backgroundColor: Colors.black
      ),*/
      body: Stack(
        children: [
          BlocBuilder<MyLocationBloc, MyLocationState>(
            builder: (context, state) => _mapGoogle(state)
          ),
          Stack(
            children: [
              BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
              return Positioned(
                width: MediaQuery.of(context).size.width * 0.9,
                bottom: 30,
                //child: Center(
                  child: Slider(
                  value: radio,
                  min: 1000,
                  max: 100000,
                  onChanged: (value) async {
                    setState(() => radio = value);

                    _setCricleMarker(state.centerLocation != null ? state.centerLocation : latLng);
                })
                //),
              );})
            ],
          )
        ],
      )
    );
  }

  /*Widget _mapOms() {
    return Expanded(
      child: FlutterMap(
        options: MapOptions(
          center: latLng,
          zoom: 12,
          onPositionChanged: (position, hasGesture) async {
            setState(() => latLng = position.center);
          },
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']
            /*urlTemplate: "https://api.mapbox.com/v4/"
                "{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}",
            additionalOptions: {
              'accessToken': ACCESS_TOKEN,
              'id': 'mapbox.streets',
            }*/
          ),
          MarkerLayerOptions(
            markers: [
              Marker(
                width: radio * 2,
                height: radio * 2,
                point: latLng,
                builder: (ctx) =>
                  Container(
                    //child: Image(image: R.image.location_mark(), fit: BoxFit.fill),
                    decoration: new BoxDecoration(
                      color: Colors.blueAccent.withOpacity(0.3),
                      shape: BoxShape.circle,
                    )
                  ),
                ),
            ],
          )
        ]
      )
    );
  }*/

  Widget _mapGoogle(MyLocationState state) {
    final mapBloc =  BlocProvider.of<MapBloc>(context);

    final cameraPosition = CameraPosition(
      target: (state.location != null) ? state.location : latLng,
      zoom: 12
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
        new Factory<OneSequenceGestureRecognizer>(() => new EagerGestureRecognizer(),),
      ].toSet(),
      //compassEnabled: true,
      //onMapCreated: (GoogleMapController controller) => mapBloc.initMap(controller),
      onMapCreated: mapBloc.initMap,
      //myLocationButtonEnabled: true,
      myLocationEnabled: true,
      //zoomControlsEnabled: true,
      onCameraMove: (cameraPosition) {
        mapBloc.add(OnCangedCenterMap(cameraPosition.target));
        _setCricleMarker(cameraPosition.target);
      },
      circles: _circles,
    );
  }

  void _setCricleMarker(LatLng point) {
    setState(() {
      _circles.clear();
      _circles.add(Circle(
        circleId: CircleId('1'),
        center: point,
        radius: radio,
        fillColor: Colors.blueAccent.withOpacity(0.5),
        strokeWidth: 0
      ));
    });
  }
}