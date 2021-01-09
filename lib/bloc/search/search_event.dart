part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnActivate extends SearchEvent{}

class OnDesactivate extends SearchEvent{}

class OnAddHistory extends SearchEvent{
  final SearchResult placeResult;
  OnAddHistory(this.placeResult);
}
