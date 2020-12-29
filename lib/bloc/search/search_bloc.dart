import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:rxdart/rxdart.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc({this.searchApi}) : super(SearchState.initial());

  final SearchApi searchApi;

  @override
  Stream<Transition<SearchEvent, SearchState>> transformEvents(
      Stream<SearchEvent> events, transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap(transitionFn);
  }

  @override
  Stream<SearchState> mapEventToState(
    SearchEvent event,
  ) async* {
    if (event is SearchTermChanged) {
      yield* _mapSearchTermChangedToState(event, state);
    }
  }

  Stream<SearchState> _mapSearchTermChangedToState(
    SearchTermChanged event,
    SearchState state,
  ) async* {
    if (event.term.isEmpty) {
      yield const SearchState.initial();
      return;
    }

    if (state.status != SearchStatus.success) {
      yield const SearchState.loading();
    }

    try {
      // var suggestions = await searchApi.getSuggestion(event.term);
      // print(suggestions);
      // yield SearchState.success(suggestions);
      yield const SearchState.failure();
    } on Exception {
      print("Failed");
      yield const SearchState.failure();
    }
  }
}
