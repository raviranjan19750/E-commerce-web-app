part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {}

class InitializeDummyFilter extends FilterEvent {}

class ChangeFilterEvent extends FilterEvent {
  final String filterCatergoryID;
  final FilterCategoryChild filterChild;
  final bool value;

  ChangeFilterEvent(this.filterCatergoryID, this.filterChild, this.value);
}
