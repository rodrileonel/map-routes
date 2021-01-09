import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:googlemaps/models/search_result.dart';
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
    if(event is OnAddHistory){
      //evitar repetidos
      final exists = state.history.where((element) => 
        element.name == event.placeResult.name
      ).length;
      
      if(exists == 0){
        //agregar a la lista
        final newPlaceHistory = [...state.history,event.placeResult];
        yield state.copyWith(history:newPlaceHistory);
      }
    }
  }
}
