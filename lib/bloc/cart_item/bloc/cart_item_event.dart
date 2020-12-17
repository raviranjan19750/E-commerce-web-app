part of 'cart_item_bloc.dart';

abstract class CartItemEvent extends Equatable {
  const CartItemEvent();

  @override
  List<Object> get props => [];
}

class UpdateCartItemQuantity extends CartItemEvent {
  final int quantity;

  UpdateCartItemQuantity(this.quantity);
}

class ChangeQuantityCart extends CartItemEvent {
  final String key;
  final int quantity;
  final String authID;

  ChangeQuantityCart(
      this.key,
      this.quantity,
      this.authID,
      );
}

class DeleteCart extends CartItemEvent {
  final String key;
  final String authID;

  DeleteCart(
      this.key,
      this.authID,
      );
}
