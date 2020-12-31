part of 'location_bloc.dart';

@immutable
class LocationState {

  final bool following;
  final bool existLocation;
  final LatLng location;

  LocationState({this.following = true, this.existLocation = false, this.location});

  LocationState copyWith({
    following, 
    existLocation,
    location
  }) => new LocationState(
    following: following ?? this.following,
    existLocation: existLocation ?? this.existLocation,
    location: location ?? this.location,
  );

}
//AIzaSyDzDh3mEkSddyiLA8mnNnrdYRRymskkzOc