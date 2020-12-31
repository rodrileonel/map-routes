part of 'map_bloc.dart';

@immutable
class MapState {
  final bool readyMap;

  MapState({
    this.readyMap = false
  });

  MapState copyWith({
    bool readyMap
  }) => MapState(
    readyMap: readyMap ?? this.readyMap
  );
}
