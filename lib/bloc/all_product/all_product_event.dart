part of 'all_product_bloc.dart';

@immutable
abstract class AllProductEvent {}

class InitializeLoadingProduct extends AllProductEvent {}

class LoadAllProductWithSearchParams extends AllProductEvent {
  final String filterText;
  final List<Map<String, dynamic>> filters;
  final FilterSortCriteria sort;

  LoadAllProductWithSearchParams({this.filterText, this.filters, this.sort});
}

class LoadNextProduct extends AllProductEvent {}
