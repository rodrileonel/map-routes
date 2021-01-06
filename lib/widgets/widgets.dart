import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/helpers/alert.dart';
import 'package:polyline/polyline.dart' as Pline;

import 'package:googlemaps/bloc/location/location_bloc.dart';
import 'package:googlemaps/bloc/map/map_bloc.dart';
import 'package:googlemaps/bloc/search/search_bloc.dart';
import 'package:googlemaps/models/search_result.dart';
import 'package:googlemaps/search/destination.dart';
import 'package:googlemaps/services/traffic_service.dart';

part 'btn_location.dart';
part 'btn_route.dart';
part 'btn_follow.dart';
part 'input_search.dart';
part 'pin.dart';