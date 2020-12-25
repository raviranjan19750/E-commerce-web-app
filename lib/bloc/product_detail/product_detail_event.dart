part of 'product_detail_bloc.dart';

@immutable
abstract class ProductDetailEvent {}

class LoadProductDetail extends ProductDetailEvent{

  final String productID;
  final String variantID;

  LoadProductDetail(this.productID, this.variantID);

}

class LoadProductVariantDetail extends ProductDetailEvent{

  final String productID;
  final List<ProductVariantColor> color;
  final String size;

  LoadProductVariantDetail(this.productID, this.color, this.size);

}

