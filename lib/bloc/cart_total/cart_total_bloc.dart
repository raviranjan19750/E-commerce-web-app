import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
part 'cart_total_event.dart';
part 'cart_total_state.dart';

class CartTotalBloc extends Bloc<CartTotalEvent, CartTotalState> {
  final CartRepository cartRepository;
  double subTotal;

  CartTotalBloc({
    this.cartRepository,
  })  : assert(cartRepository != null),
        super(CartTotalInitial(
            totalQuantity: cartRepository.totalCartItem,
            retailTotal: cartRepository.cartRetailTotal,
            discountTotal: cartRepository.cartDiscountedTotal));

  @override
  Stream<CartTotalState> mapEventToState(
    CartTotalEvent event,
  ) async* {
    if (event is UpdateCartTotal) {
      yield CartTotalUpdate(
          totalQuantity: cartRepository.totalCartItem,
          retailTotal: cartRepository.cartRetailTotal,
          discountTotal: cartRepository.cartDiscountedTotal);
    }
  }

  // Stream<CartTotalState> updateCartDetail(
  //     UpdateCartTotal event, CartTotalState state) async* {
  //   cart.forEach((element) {
  //     subTotal = subTotal + element.quantity * element.discountPrice;
  //   });
  //   yield CartTotalUpdateInitial(subTotal);
  //   try {
  //     yield CartTotalUpdate(subTotal);
  //   } catch (e) {
  //     yield CartTotalUpdateFailure(subTotal);
  //   }
  // }
}
