import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;
import 'package:googlemaps/bloc/map/map_bloc.dart';
import 'package:googlemaps/bloc/search/search_bloc.dart';
import 'package:googlemaps/helpers/alert.dart';
import 'package:googlemaps/services/traffic_service.dart';
import 'package:polyline/polyline.dart' as Pline;

Future calculateWay(BuildContext context, LatLng start, LatLng end, String nameDestine) async {

    showAlert(context, 'Calculando..', 'Obteniendo ruta');

    final trafficService = TrafficService();

    final route = await trafficService.getCoords(start, end);

    if(nameDestine==''){
      final coordsInfo = await trafficService.getCoordsInfo(end);
      nameDestine = coordsInfo.features[0].text;
    }

    final geometry = route.routes[0].geometry;
    final duration = route.routes[0].duration;
    final distance = route.routes[0].distance;

    // Decodificar los puntos de mapbox (geometry)
    final points = Pline.Polyline.Decode(encodedString: geometry, precision: 6).decodedCoords;
    //final List<LatLng> puntos = points.map((point) => LatLng(point[0],point[1])).toList();

    List<LatLng> puntos = List();

    for (var i = 0; i < points.length-1; i++) {
      final routePoint = await trafficService.getCoords(LatLng(points[i][0],points[i][1]), LatLng(points[i+1][0],points[i+1][1]));
      final geometryPoint = routePoint.routes[0].geometry;
      final pointsPoint = Pline.Polyline.Decode(encodedString: geometryPoint, precision: 6).decodedCoords;
      pointsPoint.forEach((point) {
        puntos.add(LatLng(point[0],point[1]));
      });
    }
    BlocProvider.of<MapBloc>(context).add(OnCreateRoute(puntos,duration,distance,nameDestine));
    BlocProvider.of<SearchBloc>(context).add(OnDesactivate());

    Navigator.pop(context);

}