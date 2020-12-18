part of 'cart_total_bloc.dart';

abstract class CartTotalEvent extends Equatable {
  const CartTotalEvent();

  @override
  List<Object> get props => [];
}

class InitialCartTotal extends CartTotalEvent {
  final List<Cart> cart;

  InitialCartTotal(this.cart);
}

class UpdateCartTotal extends CartTotalEvent {
  final List<Cart> cart;

  UpdateCartTotal(this.cart);
}
