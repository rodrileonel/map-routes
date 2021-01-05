import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchState());

  @override
  Stream<SearchState> mapEventToState(SearchEvent event,) async* {
    if(event is OnActivate)
      yield state.copyWith(pin: true);
    if(event is OnDesactivate)
      yield state.copyWith(pin: false);
  }
}
