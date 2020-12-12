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
  final int quantity;
  final String authID;

  ChangeQuantityCart(
    this.key,
    this.quantity,
    this.authID,
  );
}

class DeleteCart extends CartEvent {
  final String key;
  final String authID;

  DeleteCart(
    this.key,
    this.authID,
  );
}
