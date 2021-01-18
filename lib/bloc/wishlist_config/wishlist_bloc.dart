import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistConfigBloc extends Bloc<WishlistConfigEvent, WishlistConfigState> {

  final CustomerDetailRepository customerRepository;

  WishlistConfigBloc({this.customerRepository})
      : assert(customerRepository != null),
        super(WishlistConfigInitial(customerRepository.totalItemInWishList));

  @override
  Stream<WishlistConfigState> mapEventToState(
    WishlistConfigEvent event,
  ) async* {
    if (event is UpdateWishConfigList) {
      yield UpdatedWishConfigList(customerRepository.totalItemInWishList);
    } else if (event is GetWishlistFromServer) {
      await customerRepository.getWishlist(authID: event.uid);
      yield UpdatedWishConfigList(customerRepository.totalItemInWishList);
    } else if (event is ResetWishList) {
      customerRepository.resetWishList();
      yield UpdatedWishConfigList(customerRepository.totalItemInWishList);
    } else if (event is UpdateWishList) {
      if (event.wishlist != null) {
        List<String> data = event.wishlist.map((e) => e.variantID).toList(growable: true);
        customerRepository.resetWishlistWithData(data);
      }
    }
    yield UpdatedWishConfigList(customerRepository.totalItemInWishList);
  }
}
