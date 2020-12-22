import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
part 'cart_total_event.dart';
part 'cart_total_state.dart';

class CartTotalBloc extends Bloc<CartTotalEvent, CartTotalState> {
  final List<Cart> cart;
  final CustomerDetailRepository customerDetailRepository;
  double subTotal;

  CartTotalBloc({
    this.cart,
    this.customerDetailRepository,
  })  :
        //assert(cart != null),
        assert(customerDetailRepository != null),
        super(CartTotalInitial());

  @override
  Stream<CartTotalState> mapEventToState(
    CartTotalEvent event,
  ) async* {
    if (event is UpdateCartTotal) {
      yield CartTotalUpdate(customerDetailRepository.cartTotal);
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
