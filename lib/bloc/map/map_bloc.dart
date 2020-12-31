import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/themes/map.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _googleMapController;

  void initMap(GoogleMapController googleMapController){
    if(!state.readyMap){
      this._googleMapController = googleMapController;
      this._googleMapController.setMapStyle(jsonEncode(mapTheme));
      add(OnMapReady());
    }
  }

  void moveCamera(LatLng destine){
    final cameraUpdate = CameraUpdate.newLatLng(destine);
    this._googleMapController?.moveCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState( MapEvent event ) async* {
    if(event is OnMapReady)
      yield state.copyWith(readyMap:true);
  }
}
