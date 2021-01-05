part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class OnActivate extends SearchEvent{}

class OnDesactivate extends SearchEvent{}
