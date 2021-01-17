part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;
  final bool dwawLine;
  final bool follow;
  final LatLng central;
  final Map<String,Polyline> polylines;
  final Map<String,Marker> marker;

  MapState( {
    this.readyMap = false,
    this.dwawLine = false,
    this.follow = false,
    this.central,
    Map<String,Polyline> polylines,
    Map<String,Marker> marker,
  }): this.polylines = polylines??Map(),
      this.marker = marker??Map();

  MapState copyWith({
    bool readyMap,
    bool dwawLine,
    bool follow,
    LatLng central,
    Map<String,Polyline> polylines,
    Map<String,Marker> marker,
  }) => MapState(
    readyMap: readyMap ?? this.readyMap,
    dwawLine: dwawLine ?? this.dwawLine,
    follow: follow ?? this.follow,
    central: central ?? this.central,
    polylines: polylines ?? this.polylines,
    marker: marker ?? this.marker,
  );
}
