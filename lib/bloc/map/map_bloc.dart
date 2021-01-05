import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/themes/map.dart';
import 'package:meta/meta.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  GoogleMapController _googleMapController;

  Polyline _ruta = Polyline(
    polylineId: PolylineId('ruta'),
    color: Colors.transparent,
    width: 3,
  );

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
    if(event is OnLocationUpdate)
      yield* _onLocationUpdate(event);
    if(event is OnShowRoute)
      yield* _onShowRoute(event);
    if(event is OnFollow)
      yield* _onFollow(event);
    if(event is OnMoveMap)
      yield state.copyWith(central: event.center);
  }

  Stream<MapState> _onLocationUpdate(OnLocationUpdate event) async*{
    if(state.follow!=null && state.follow)
      moveCamera(event.location);
    List<LatLng> points = [ ...this._ruta.points, event.location ];
    this._ruta = this._ruta.copyWith( pointsParam: points); //google maps viene con su copywith
    final currentPolylines = state.polylines;
    currentPolylines['ruta'] = this._ruta;
    yield state.copyWith(polylines:currentPolylines);
  }

  Stream<MapState> _onShowRoute(OnShowRoute event) async*{
    if(!state.dwawLine)
      this._ruta = this._ruta.copyWith( colorParam: Colors.black87);
    else
      this._ruta = this._ruta.copyWith( colorParam: Colors.transparent);

    final currentPolylines = state.polylines;
    currentPolylines['ruta'] = this._ruta;

    yield state.copyWith(
      dwawLine: !state.dwawLine,
      polylines:currentPolylines
    );
  }

  Stream<MapState> _onFollow(OnFollow event) async*{
    //si la persona qiere moverse esta en false
    if(!state.follow) // mueve la cama aun si la persona dejo de moverse
      this.moveCamera(this._ruta.points[this._ruta.points.length-1]);
    yield state.copyWith(follow: !state.follow);
  }
}
