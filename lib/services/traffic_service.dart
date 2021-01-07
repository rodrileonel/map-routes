
import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/models/route_response.dart';

class TrafficService{

  //Singleton
  TrafficService._init();
  static final TrafficService _instance = TrafficService._init();
  factory TrafficService() => _instance;

  final _dio = Dio();
  final _baseURL = 'https://api.mapbox.com/directions/v5';
  final _apiKey = 'pk.eyJ1Ijoicm9kcmlnb2xlb25lbCIsImEiOiJja2ZvMzF2dWQyMG9yMnFwazMzZzFjMGxhIn0.SCYMz8xC6PI1d9tn_29FPg';

  Future<RouteResponse> getCoords(LatLng start, LatLng end) async{
    //en mapbox primero se manda la longitud y luego la latitud
    final cords = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '${this._baseURL}/mapbox/driving/$cords';

    //armando get con Dio
    final response = await _dio.get(url, queryParameters:{
      'alternatives':'true',
      'geometries':'polyline6',
      'steps':'false',
      'access_token':_apiKey,
      'language':'es',
    });

    return RouteResponse.fromJson(response.data);
  }

}