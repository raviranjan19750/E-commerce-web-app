import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:living_desire/models/mini_cart.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';

part 'cart_config_event.dart';
part 'cart_config_state.dart';

class CartConfigBloc extends Bloc<CartConfigEvent, CartConfigState> {

  final CustomerDetailRepository customerRepository;

  CartConfigBloc({this.customerRepository}) :
        assert(customerRepository != null),
        super(CartConfigInitial(customerRepository.totalItemsInCart));

  @override
  Stream<CartConfigState> mapEventToState(
    CartConfigEvent event,
  ) async* {
    if (event is UpdateCartConfigList) {

    } else if (event is GetCartItemsFromServer) {
      await customerRepository.getAllCartItems(authID: event.uid);
    } else if (event is ResetCartList) {
      customerRepository.resetCartList();
    } else if (event is UpdateCartList) {
      if (event.cartItems != null) {

      }
    }
    yield UpdatedCartConfigList(customerRepository.totalItemsInCart);
  }
}
