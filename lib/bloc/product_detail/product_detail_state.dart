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


// // checking loading of enlarged image of product
// class ProductDetailImageLoading extends ProductDetailState{}
//
// class ProductDetailImageLoadingSuccessful extends ProductDetailState{}
//
// class ProductDetailImageLoadingFailure extends ProductDetailState{}

// use loading widget google


// checking image list of product
// class ProductDetailImageListLoading extends ProductDetailState{}
//
// class ProductDetailImageListLoadingSuccessful extends ProductDetailState{}
//
// class ProductDetailImageListLoadingFailure extends ProductDetailState{}


// check availability of product
class ProductDetailAvailabilityChecking extends ProductDetailState{}

class ProductDetailAvailabilityCheckingSuccessful extends ProductDetailState{}

class ProductDetailAvailabilityCheckingFailure extends ProductDetailState{}





