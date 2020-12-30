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
  final String variantID;
  final List<ProductVariantColor> color;
  final String size;

  LoadProductVariantDetail(this.productID, this.variantID, this.color, this.size);

}


// add cart
// buy now
// customize with logo
// checking availability for product
