part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapDispose;
  final LatLng centerLocation;

  MapState({
    this.mapDispose =  false,
    this.centerLocation
  });

  MapState copyWith({
    bool mapDispose,
    LatLng centerLocation
  }) => MapState(
    mapDispose: mapDispose ?? this.mapDispose,
    centerLocation: centerLocation ?? this.centerLocation
  );
}
