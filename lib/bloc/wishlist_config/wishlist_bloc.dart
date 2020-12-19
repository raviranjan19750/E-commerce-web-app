import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistConfigBloc extends Bloc<WishlistConfigEvent, WishlistConfigState> {

  final CustomerDetailRepository customerRepository;

  WishlistConfigBloc({this.customerRepository})
      : assert(customerRepository != null),
        super(WishlistConfigInitial(customerRepository.totalItemInCart));

  @override
  Stream<WishlistConfigState> mapEventToState(
    WishlistConfigEvent event,
  ) async* {
    if (event is UpdateWishConfigList) {
      yield UpdatedWishConfigList(customerRepository.totalItemInCart);
    }
  }
}
