part of 'cart_bloc.dart';

abstract class CartEvent {}

class InitializeLoadingCart extends CartEvent {}

class LoadAllCart extends CartEvent {
  final String authID;

  LoadAllCart(
    this.authID,
  );
}
