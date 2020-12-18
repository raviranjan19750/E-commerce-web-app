import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {

  final CustomerDetailRepository customerRepository;

  WishlistBloc({this.customerRepository})
      : assert(customerRepository != null),
        super(WishlistInitial(customerRepository.totalItemInCart));

  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if (event is UpdateWishList) {
      yield UpdatedWishList(customerRepository.totalItemInCart);
    }
  }
}
