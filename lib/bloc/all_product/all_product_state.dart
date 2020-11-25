part of 'all_product_bloc.dart';

@immutable
abstract class AllProductState {
  Map<String, List<FilterCriteria>> map = new HashMap();

  void reset() {
    map = new HashMap();
  }
}

class AllProductInitial extends AllProductState {

}

class DummyProducts extends AllProductState {

}

class FilterCriteria {
  final String title;
  final bool selected;
  FilterCriteria(this.title, {this.selected = false});
}