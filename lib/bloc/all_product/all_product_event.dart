part of 'all_product_bloc.dart';

@immutable
abstract class AllProductEvent {}

class InitializeLoadingProduct extends AllProductEvent {}

class LoadAllProductWithSearchParams extends AllProductEvent {
  final String filterText;
  final List<Map<String, dynamic>> filters;

  LoadAllProductWithSearchParams({this.filterText, this.filters});
}

class LoadNextProduct extends AllProductEvent {}
