part of 'all_product_bloc.dart';

@immutable
abstract class AllProductEvent {}

class InitializeLoadingProduct extends AllProductEvent {}

class LoadAllProductWithSearchParams extends AllProductEvent {
  final String filterText;

  LoadAllProductWithSearchParams({ this.filterText });
}

class LoadNextProduct extends AllProductEvent {}