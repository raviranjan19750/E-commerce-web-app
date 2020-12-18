part of 'product_card_bloc.dart';

abstract class ProductCardEvent extends Equatable {
  const ProductCardEvent();

  @override
  List<Object> get props => [];
}

class AddToWishListProductEvent extends ProductCardEvent {}

class RemoveFromWishListProductEvent extends ProductCardEvent {}