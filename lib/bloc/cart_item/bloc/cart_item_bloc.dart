import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/bloc/cart/cart_bloc.dart';
import 'package:living_desire/bloc/cart_total/cart_total_bloc.dart';
import 'package:living_desire/models/models.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
part 'cart_item_event.dart';
part 'cart_item_state.dart';

// Cart Item Bloc
class CartItemBloc extends Bloc<CartItemEvent, CartItemState> {
  final CartRepository cartRepository;
  final Cart cart;
  final CartTotalBloc cartTotalBloc;
  final CartBloc cartBloc;

  CartItemBloc({
    this.cartBloc,
    this.cartRepository,
    this.cart,
    this.cartTotalBloc,
  })  : assert(cartBloc != null),
        assert(cartRepository != null),
        assert(cart != null),
        assert(cartTotalBloc != null),
        super(CartItemInitial(cart, CartItemStateType.INITIAL));

  // Cart Item Events
  @override
  Stream<CartItemState> mapEventToState(
    CartItemEvent event,
  ) async* {
    if (event is DeleteCart) {
      yield* deleteCartDetail(event, state);
    } else if (event is ChangeQuantityCart) {
      yield* changeQuantityCartDetail(event, state);
      cartTotalBloc.add(UpdateCartTotal());
    }
  }

  Stream<CartItemState> deleteCartDetail(
      DeleteCart event, CartItemState state) async* {
    yield CartItemUpdate(state.cart, CartItemStateType.LOADING);
    try {
      if (event.authID != null) {
        await cartRepository.deleteCartDetails(
          key: event.key,
          productID: event.productID,
          authID: event.authID,
        );
        yield CartItemUpdate(state.cart, CartItemStateType.SUCCESS);
        cartBloc.add(RefreshCart());
      } else {
        Cart itm = new Cart(
          key: event.key,
          productID: event.productID,
        );
        NormalLocalStorage(itm).deleteFromLocalStorage(itm.key);
        cartRepository.deleteCartLocalData(itm.key);
        yield CartItemUpdate(state.cart, CartItemStateType.SUCCESS);
        cartBloc.add(RefreshCart());
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield CartItemUpdate(state.cart, CartItemStateType.FAILURE);
    }
  }

  Stream<CartItemState> changeQuantityCartDetail(
      ChangeQuantityCart event, CartItemState state) async* {
    yield CartItemUpdate(state.cart, CartItemStateType.LOADING);
    try {
      if (event.authID != null) {
        if (event.quantity == 0) {
          await cartRepository.deleteCartDetails(
            key: event.key,
            productID: event.productID,
            authID: event.authID,
          );
          cartBloc.add(RefreshCart());
        } else {
          await cartRepository.changeQuantityCartDetails(
            event.key,
            event.quantity,
          );
          state.cart.quantity = event.quantity;
          yield CartItemUpdate(state.cart, CartItemStateType.SUCCESS);
        }
      } else {
        if (event.quantity == 0) {
          Cart itm = new Cart(
            key: event.key,
            productID: event.productID,
          );
          NormalLocalStorage(itm).deleteFromLocalStorage(itm.key);
          cartRepository.deleteCartLocalData(itm.key);
          cartBloc.add(RefreshCart());
        } else {
          Cart itm = new Cart(
            key: event.key,
            productID: event.productID,
            quantity: event.quantity,
          );
          NormalLocalStorage(itm)
              .changeQuantityFromLocalStorage(itm.key, itm.quantity);
          state.cart.quantity = event.quantity;
          cartRepository.changeCartLocalData(itm.key, itm.quantity);
          yield CartItemUpdate(state.cart, CartItemStateType.SUCCESS);
        }
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield CartItemUpdate(state.cart, CartItemStateType.FAILURE);
    }
  }
}

// Not logged In Add Item In Cart
