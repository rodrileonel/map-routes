part of 'search_bloc.dart';

@immutable
class SearchState {
  final bool pin;
  final List<SearchResult> history;

  SearchState({
    this.pin = false,
    List<SearchResult> history
  }):this.history = (history==null)?[]:history;

  SearchState copyWith({
    bool pin,
    List<SearchResult> history
  }) => SearchState(
    pin: pin ?? this.pin,
    history: history ?? this.history,
  );
}
