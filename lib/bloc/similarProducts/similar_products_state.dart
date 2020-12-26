part of 'similar_products_bloc.dart';

@immutable
abstract class SimilarProductsState {}

class SimilarProductsInitial extends SimilarProductsState {}

class SimilarProductsLoading extends SimilarProductsState {}

class SimilarProductsLoadingSuccessful extends SimilarProductsState {

  final List<Product> product;

  SimilarProductsLoadingSuccessful(this.product);

}

class SimilarProductsLoadingFailure extends SimilarProductsState {}


