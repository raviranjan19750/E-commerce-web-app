part of 'product_card_bloc.dart';

abstract class ProductCardState {
  var product;
  final bool isItemInWishList;
  final bool isItemInCart;

  ProductCardState(this.product, this.isItemInWishList, this.isItemInCart);

  @override
  String toString() {
    return 'ProductCardState{product: $product, isItemInWishList: $isItemInWishList}';
  }
}

class ProductCardInitial extends ProductCardState {
  ProductCardInitial(var product, bool isItemInWishList, bool isItemInCart)
      : super(product, isItemInWishList, isItemInCart);
}

class UpdatedProductCard extends ProductCardState {
  UpdatedProductCard(var product, bool isItemInWishList, bool isItemInCart)
      : super(product, isItemInWishList, isItemInCart);
}
