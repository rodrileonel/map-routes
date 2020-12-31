part of 'location_bloc.dart';

@immutable
abstract class LocationEvent {}

class OnLocationChanged extends LocationEvent{
  final LatLng location;
  OnLocationChanged(this.location);
}
