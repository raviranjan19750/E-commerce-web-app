part of 'product_card_bloc.dart';

abstract class ProductCardState {
  var product;
  final bool isItemInWishList;

  ProductCardState(this.product, this.isItemInWishList);

  @override
  String toString() {
    return 'ProductCardState{product: $product, isItemInWishList: $isItemInWishList}';
  }
}

class ProductCardInitial extends ProductCardState {
  ProductCardInitial(var product, bool isItemInWishList)
      : super(product, isItemInWishList);
}

class UpdatedProductCard extends ProductCardState {
  UpdatedProductCard(var product, bool isItemInWishList)
      : super(product, isItemInWishList);
}
