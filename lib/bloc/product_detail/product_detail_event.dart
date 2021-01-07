part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent {
  final String productID;
  final String variantID;
  final String authID;

  LoadProductDetail({this.productID, this.variantID, this.authID});
}

class LoadComboProductDetail extends ProductDetailEvent {
  final String productID;
  final String authID;

  LoadComboProductDetail({this.productID, this.authID});
}

// add cart
// buy now
// customize with logo
// checking availability for product
