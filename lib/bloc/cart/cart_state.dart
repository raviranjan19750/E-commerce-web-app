part of 'cart_bloc.dart';

abstract class CartState {}

class CartDetailInitial extends CartState {}

class CartDetailLoading extends CartState {}

// ignore: must_be_immutable
class CartDetailLoadingSuccessful extends CartState {
  final List<Cart> cart;

  CartDetailLoadingSuccessful(this.cart);
}

class CartDetailLoadingFailure extends CartState {}

class DeleteCartDetailLoading extends CartState {}

class DeleteCartDetailLoadingSuccessful extends CartState {}

class DeleteCartDetailLoadingFailure extends CartState {}

class AddCartDetailLoadingSuccessful extends CartState {}

class AddCartDetailLoadingFailure extends CartState {}

class ChangeQuantityCartDetailLoading extends CartState {}

class ChangeQuantityCartDetailLoadingSuccessful extends CartState {}

class ChangeQuantityCartDetailLoadingFailure extends CartState {}
