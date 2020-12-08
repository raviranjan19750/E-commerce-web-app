part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent{

  final String productID;

  LoadProductDetail(this.productID);

}

// add cart
// buy now
// customize with logo
// checking availability for product
