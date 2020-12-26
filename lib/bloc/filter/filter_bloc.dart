import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:living_desire/bloc/all_product/all_product_bloc.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final SearchApi searchApi;
  final AllProductBloc allProductBloc;

  FilterBloc({this.searchApi, this.allProductBloc})
      : assert(searchApi != null),
        assert(allProductBloc != null),
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
    List<FilterTag> newFilters = List.empty(growable: true);
    for (var t in curTags) {
      if (t.tag == event.filterCatergoryID) {
        FilterTag tag = FilterTag(event.filterCatergoryID, t.keyword,
            description: t.description);
        for (var ch in t.filterChilds) {
          if (ch == event.filterChild) {
            FilterCategoryChild filterChild =
                FilterCategoryChild(ch.filterID, ch.description, event.value);
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
    // Build Filter Array Based On the selected terms
    List<Map<String, dynamic>> filterCriteria = List.empty(growable: true);
    for (var t in newFilters) {
      List<String> criteriaChild = List.empty(growable: true);
      for (var u in t.filterChilds) {
        if (u.selected) {
          criteriaChild.add(u.filterID);
        }
      }
      if (criteriaChild.isNotEmpty) {
        filterCriteria.add(_buildFilterCriteria(t.keyword, criteriaChild));
      }
    }
    print(filterCriteria);
    allProductBloc.add(LoadAllProductWithSearchParams(filters: filterCriteria));
    yield DummyFilterState(newFilters);
  }

  Map<String, dynamic> _buildFilterCriteria(
      String filterTag, List<String> filters) {
    Map<String, dynamic> map = Map();

    Map<String, dynamic> map_1 = Map();
    map_1.putIfAbsent(filterTag, () => filters);

    map.putIfAbsent("terms", () => map_1);
    return map;
  }
}
