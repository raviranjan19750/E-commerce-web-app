part of 'all_product_bloc.dart';

@immutable
abstract class AllProductState {}

class AllProductInitial extends AllProductState {}

class LoadingAllProduct extends AllProductState {}

class SuccessLoadingAllProduct extends AllProductState {
  final List<Product> productList;
  final int limit;
  final int offset;
  final int totalResults;

  SuccessLoadingAllProduct(this.productList, {this.limit, this.offset, this.totalResults});
}

class FailureLoadingProduct extends AllProductState {}

class LoadingNextProduct extends AllProductState{}