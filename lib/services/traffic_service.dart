
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/helpers/debouncer.dart';
import 'package:googlemaps/models/route_response.dart';
import 'package:googlemaps/models/search_response.dart';

class TrafficService{

  //Singleton
  TrafficService._init();
  static final TrafficService _instance = TrafficService._init();
  factory TrafficService() => _instance;

  final _dio = Dio();
  
  //debouncer
  //esto es para esperar un tiempo hasta que el usuario vuelva a escribir
  final debouncer = Debouncer<String>(duration: Duration(milliseconds: 500 ));
  final StreamController<SearchResponse> _suggestionsStream = StreamController<SearchResponse>.broadcast();
  Stream<SearchResponse> get suggestionsStream => this._suggestionsStream.stream;

  final _baseURLDir = 'https://api.mapbox.com/directions/v5';
  final _baseURLGeo = 'https://api.mapbox.com/geocoding/v5';
  final _apiKey = 'pk.eyJ1Ijoicm9kcmlnb2xlb25lbCIsImEiOiJja2ZvMzF2dWQyMG9yMnFwazMzZzFjMGxhIn0.SCYMz8xC6PI1d9tn_29FPg';

  Future<RouteResponse> getCoords(LatLng start, LatLng end) async{
    //en mapbox primero se manda la longitud y luego la latitud
    final cords = '${start.longitude},${start.latitude};${end.longitude},${end.latitude}';
    final url = '${this._baseURLDir}/mapbox/driving/$cords';

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

  Future<SearchResponse> gerResults(String search,LatLng proximity) async{
    final url = '${this._baseURLGeo}/mapbox.places/$search.json';

    try {
      final response = await this._dio.get(url, queryParameters:{
        'access_token':this._apiKey,
        'autocomplete':'true',
        'proximity':'${proximity.longitude},${proximity.latitude}',
        'language':'es'
      });

      //el servicio no me devuelve un json sino un string como json, por eso uso este método
      return searchResponseFromJson(response.data);

    } catch (e) {
      return SearchResponse( features:[]);
    }
  }

  void getSugerenciasPorQuery( String busqueda, LatLng proximidad ) {

    debouncer.value = '';
    debouncer.onValue = ( value ) async {
      final resultados = await this.gerResults(value, proximidad);
      this._suggestionsStream.add(resultados);
    };

    final timer = Timer.periodic(Duration(milliseconds: 200), (_) {
      debouncer.value = busqueda;
    });

    Future.delayed(Duration(milliseconds: 201)).then((_) => timer.cancel()); 

  }
}