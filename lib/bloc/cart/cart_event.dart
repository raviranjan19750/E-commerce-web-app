part of 'cart_bloc.dart';

abstract class CartEvent {}

class InitializeLoadingCart extends CartEvent {}

class LoadAllCart extends CartEvent {
  final String authID;

  LoadAllCart(
    this.authID,
  );
}

class AddCart extends CartEvent {
  final String authID;
  final String productID;
  final String variantID;
  final int quantity;

  AddCart({
    this.authID,
    this.quantity,
    this.productID,
    this.variantID,
  });
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
  final String productID;

  DeleteCart({
    this.key,
    this.authID,
    this.productID,
  });
}

class RefreshCart extends CartEvent {}
