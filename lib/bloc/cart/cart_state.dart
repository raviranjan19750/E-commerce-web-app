part of 'cart_bloc.dart';

abstract class CartState {
  final List<Cart> cart;

  CartState({this.cart});

  List<Cart> changeQuantityCartDetail(
    int quantity,
  ) {}
}

class CartDetailInitial extends CartState {
  CartDetailInitial(List<Cart> cart) : super(cart: cart);
}

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

class PrdouctCardViewState extends CartState {
  final String key;
  final List<Cart> cart;

  PrdouctCardViewState({this.key, this.cart});
}
