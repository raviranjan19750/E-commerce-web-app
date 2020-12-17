import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';

part 'cart_item_event.dart';
part 'cart_item_state.dart';

class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final CartRepository cartRepository;
  final Cart cart;

  CartItemBloc({this.cartRepository, this.cart})
      : assert(cartRepository != null),
        assert(cart != null),
        super(CartItemInitial(cart, CartItemStateType.INITIAL));

  @override
  Stream<CartItemState> mapEventToState(
    CartItemEvent event,
  ) async* {
    if (event is DeleteCart) {
      yield* deleteCartDetail(event, state);
    } else if (event is ChangeQuantityCart) {
      yield* changeQuantityCartDetail(event, state);
    }
  }

  Stream<CartItemState> deleteCartDetail(DeleteCart event, CartItemState state) async* {
    yield CartItemUpdate(state.cart, CartItemStateType.LOADING);
    try {
      await cartRepository.deleteCartDetails(event.key);
      yield CartItemUpdate(state.cart, CartItemStateType.SUCCESS);
    } catch (e) {
      yield CartItemUpdate(state.cart, CartItemStateType.FAILURE);
    }
  }

  Stream<CartItemState> changeQuantityCartDetail(ChangeQuantityCart event, CartItemState state) async* {
    yield CartItemUpdate(state.cart, CartItemStateType.LOADING);
    try {
      await cartRepository.changeQuantityCartDetails(
        event.key,
        event.quantity,
      );
      state.cart.quantity = event.quantity;
      yield CartItemUpdate(state.cart, CartItemStateType.SUCCESS);
    } catch (e) {
      yield CartItemUpdate(state.cart, CartItemStateType.FAILURE);
    }
  }
}
