part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool dwawLine;
  final bool follow;
  final LatLng central;
  final Map<String,Polyline> polylines;

  MapState( {
    this.readyMap = false,
    this.dwawLine = true,
    this.follow = false,
    this.central,
    Map<String,Polyline> polylines
  }): this.polylines = polylines??Map();

  MapState copyWith({
    bool readyMap,
    bool dwawLine,
    bool follow,
    LatLng central,
    Map<String,Polyline> polylines,
  }) => MapState(
    readyMap: readyMap ?? this.readyMap,
    dwawLine: dwawLine ?? this.dwawLine,
    follow: follow ?? this.follow,
    central: central ?? this.central,
    polylines: polylines ?? this.polylines
  );
}
