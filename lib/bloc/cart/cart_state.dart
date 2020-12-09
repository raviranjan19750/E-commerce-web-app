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
