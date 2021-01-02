part of 'similar_products_bloc.dart';

@immutable
abstract class SimilarProductsState {}

class SimilarProductsInitial extends SimilarProductsState {}

class SimilarProductsLoading extends SimilarProductsState {}

class SimilarProductsLoadingSuccessful extends SimilarProductsState {

  final List<Product> product;
  final List<ComboProduct> comboProduct;

  SimilarProductsLoadingSuccessful(this.product, this.comboProduct);

}

class SimilarProductsLoadingFailure extends SimilarProductsState {}


