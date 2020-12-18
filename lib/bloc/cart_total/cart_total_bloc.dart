import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
part 'cart_total_event.dart';
part 'cart_total_state.dart';

class CartTotalBloc extends Bloc<CartTotalEvent, CartTotalState> {
  final List<Cart> cart;
  double subTotal;

  CartTotalBloc({this.cart})
      : assert(cart != null),
        super(CartTotalInitial());

  @override
  Stream<CartTotalState> mapEventToState(
    CartTotalEvent event,
  ) async* {
    if (event is UpdateCartTotal) {
      yield* updateCartDetail(event, state);
    }
  }

  Stream<CartTotalState> updateCartDetail(
      UpdateCartTotal event, CartTotalState state) async* {
    cart.forEach((element) {
      subTotal = subTotal + element.quantity * element.discountPrice;
    });
    yield CartTotalUpdateInitial(subTotal);
    try {
      yield CartTotalUpdate(subTotal);
    } catch (e) {
      yield CartTotalUpdateFailure(subTotal);
    }
  }
}
