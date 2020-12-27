part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailState {}

class ProductDetailInitial extends ProductDetailState {}

class ProductDetailLoading extends ProductDetailState {}

// ignore: must_be_immutable
class ProductDetailLoadingSuccessful extends ProductDetailState {

  final ProductDetail productDetail;

  ProductDetailLoadingSuccessful(this.productDetail);

}

class ProductDetailLoadingFailure extends ProductDetailState {}

class SimilarProductDetailLoadingSuccessful extends ProductDetailState {

  final List<Product> productDetail;

  SimilarProductDetailLoadingSuccessful(this.productDetail);

}



// check availability of product





