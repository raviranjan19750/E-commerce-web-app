part of 'cart_item_bloc.dart';

enum CartItemStateType {INITIAL, LOADING, UPDATING, SUCCESS, FAILURE}

abstract class CartItemState {
  final Cart cart;
  final CartItemStateType type;

  CartItemState(this.cart, this.type);
}

class CartItemInitial extends CartItemState {
  CartItemInitial(Cart cart, CartItemStateType type) : super(cart, type);
}

class CartItemUpdate extends CartItemState {
  CartItemUpdate(Cart cart, CartItemStateType type) : super(cart, type);
}
