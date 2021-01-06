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

  Polyline _follow = Polyline(
    polylineId: PolylineId('follow'),
    color: Colors.transparent,
    width: 3,
  );

  Polyline _route = Polyline(
    polylineId: PolylineId('route'),
    color: Colors.black87,
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
    if(event is OnCreateRoute)
      yield* _onCreateRoute(event);
  }

  Stream<MapState> _onLocationUpdate(OnLocationUpdate event) async*{
    if(state.follow!=null && state.follow)
      moveCamera(event.location);
    List<LatLng> points = [ ...this._follow.points, event.location ];
    this._follow = this._follow.copyWith( pointsParam: points); //google maps viene con su copywith
    final currentPolylines = state.polylines;
    currentPolylines['follow'] = this._follow;
    yield state.copyWith(polylines:currentPolylines);
  }

  Stream<MapState> _onShowRoute(OnShowRoute event) async*{
    if(!state.dwawLine)
      this._follow = this._follow.copyWith( colorParam: Colors.black87);
    else
      this._follow = this._follow.copyWith( colorParam: Colors.transparent);

    final currentPolylines = state.polylines;
    currentPolylines['follow'] = this._follow;

    yield state.copyWith(
      dwawLine: !state.dwawLine,
      polylines:currentPolylines
    );
  }

  Stream<MapState> _onFollow(OnFollow event) async*{
    //si la persona qiere moverse esta en false
    if(!state.follow) // mueve la cama aun si la persona dejo de moverse
      this.moveCamera(this._follow.points[this._follow.points.length-1]);
    yield state.copyWith(follow: !state.follow);
  }

  Stream<MapState> _onCreateRoute(OnCreateRoute event) async*{
    this._route = this._route.copyWith(
      pointsParam: event.route
    );

    final currentPolylines = state.polylines;
    currentPolylines['route'] = this._route;

    yield state.copyWith(
      polylines: currentPolylines,
      //todo añadir marcadores
    );
  }
}
