part of 'cart_bloc.dart';

abstract class CartEvent {}

class InitializeLoadingCart extends CartEvent {}

class LoadAllCart extends CartEvent {
  final String authID;

  LoadAllCart(
    this.authID,
  );
}

class ChangeQuantityCart extends CartEvent {
  final String key;
  final double quantity;

  ChangeQuantityCart(
    this.key,
    this.quantity,
  );
}

class DeleteCart extends CartEvent {
  final String key;

  DeleteCart(
    this.key,
  );
}
