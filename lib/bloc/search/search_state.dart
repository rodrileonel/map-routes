part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool pin;

  SearchState({
    this.pin = false
  });

  SearchState copyWith({
    bool pin
  }) => SearchState(
    pin: pin ?? this.pin
  );
}
