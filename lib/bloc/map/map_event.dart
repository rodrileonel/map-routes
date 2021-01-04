part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapReady extends MapEvent{}

class OnShowRoute extends MapEvent{}

class OnFollow extends MapEvent{}

class OnMoveMap extends MapEvent{
  final LatLng center;
  OnMoveMap(this.center);
}

class OnLocationUpdate extends MapEvent {
  final LatLng location;
  OnLocationUpdate(this.location);
}
