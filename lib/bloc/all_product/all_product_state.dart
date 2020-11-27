part of 'all_product_bloc.dart';

@immutable
abstract class AllProductState {}

class AllProductInitial extends AllProductState {}

class LoadingAllProduct extends AllProductState {}

class SuccessLoadingAllProduct extends AllProductState {
  final List<Product> productList;

  SuccessLoadingAllProduct(this.productList);
}

class FailureLoadingProduct extends AllProductState {}