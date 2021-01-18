part of 'cart_config_bloc.dart';

abstract class CartConfigEvent extends Equatable {
  const CartConfigEvent();

  @override
  List<Object> get props => [];
}

class UpdateCartConfigList extends CartConfigEvent {}

class GetCartItemsFromServer extends CartConfigEvent {
  final String uid;

  GetCartItemsFromServer(this.uid);
}

class UpdateCartList extends CartConfigEvent {
  final List<MiniCart> cartItems;

  UpdateCartList(this.cartItems);
}

class ResetCartList extends CartConfigEvent {}