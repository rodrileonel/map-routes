import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:meta/meta.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  LocationBloc() : super(LocationState());

  StreamSubscription<Position> _positionSubscription;

  void startFollowing(){
    _positionSubscription = Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.high,
      distanceFilter: 10
    ).listen((position) {
      final location = LatLng(position.latitude,position.longitude);
      add(OnLocationChanged(location));
    });
  }

  void cancelFollowing(){
    _positionSubscription?.cancel();
  }

  @override
  Stream<LocationState> mapEventToState(LocationEvent event) async* {
    if(event is OnLocationChanged)
      yield state.copyWith(
        existLocation: true,
        location: event.location
      );
  }
}
