part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnmapDispose extends MapEvent{}

class OnCangedCenterMap extends MapEvent {
  final LatLng centerLocation;

  OnCangedCenterMap(this.centerLocation);
}
