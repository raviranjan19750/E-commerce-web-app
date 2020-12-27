part of 'product_card_bloc.dart';

abstract class ProductCardState {
  final Product product;
  final bool isItemInWishList;

  ProductCardState(this.product, this.isItemInWishList);

  @override
  String toString() {
    return 'ProductCardState{product: $product, isItemInWishList: $isItemInWishList}';
  }
}

class ProductCardInitial extends ProductCardState {
  ProductCardInitial(Product product, bool isItemInWishList)
      : super(product, isItemInWishList);
}

class UpdatedProductCard extends ProductCardState {
  UpdatedProductCard(Product product, bool isItemInWishList)
      : super(product, isItemInWishList);
}
