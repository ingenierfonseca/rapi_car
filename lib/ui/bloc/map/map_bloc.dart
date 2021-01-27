import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:rapi_car_app/themes/map/map_light.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _mapController;

  void initMap(GoogleMapController controller) {
    if (!state.mapDispose) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(mapLightTheme));

      add(OnmapDispose());
    }
  }

  @override
  Stream<MapState> mapEventToState(MapEvent event) async* {
    switch(event.runtimeType) {
      case OnmapDispose:
        yield state.copyWith(mapDispose: true);
      break;
      case OnCangedCenterMap:
        yield state.copyWith(centerLocation: (event as OnCangedCenterMap).centerLocation);
      break;
    }
  }
}
