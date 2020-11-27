part of 'filter_bloc.dart';

@immutable
abstract class FilterState {
  List<FilterTag> filters;
  FilterState(this.filters);

  void reset() {
    filters = List();
  }
}

class FilterInitial extends FilterState {
  FilterInitial() : super(List());
}

class LoadFiltersFromServer extends FilterState {
  LoadFiltersFromServer(List<FilterTag> filters) : super(filters);
}

class DummyFilterState extends FilterState {
  DummyFilterState(List<FilterTag> filters) : super(filters);
}