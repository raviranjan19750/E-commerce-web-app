import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {

  final SearchApi searchApi;

  FilterBloc({ this.searchApi }) :
        assert(searchApi != null),
        super(FilterInitial());

  @override
  Stream<FilterState> mapEventToState(
    FilterEvent event,
  ) async* {
    if (event is InitializeDummyFilter) {
      List<FilterTag> tags = await searchApi.getAllCategoryTags();
      yield LoadFiltersFromServer(tags);
    } else if (event is ChangeFilterEvent) {
      yield* _onFilterChange(event);
    }
  }

  Stream<FilterState> _onFilterChange(ChangeFilterEvent event) async* {
    List<FilterTag> curTags = state.filters;
    List<FilterTag> newFilters = List();
    for (var t in curTags) {
      if (t.tag == event.filterCatergoryID) {
        // @TODO do the api request to filter.
        FilterTag tag = FilterTag(event.filterCatergoryID, description: t.description);
        for (var ch in t.filterChilds) {
          if (ch == event.filterChild) {
            FilterCategoryChild filterChild = FilterCategoryChild(ch.filterID, ch.description, event.value);
            tag.addChild(filterChild);
          } else {
            tag.addChild(ch);
          }
        }
        newFilters.add(tag);
      } else {
        newFilters.add(t);
      }
    }
    yield DummyFilterState(newFilters);
  }
}
