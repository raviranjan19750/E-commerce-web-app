import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial(List()));

  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    if (event is RemoveFromWishList) {
      state.removeFromWishList(event.productId);
      yield UpdatedWishList(state.data);
    } else if (event is AddToWishList) {
      state.addToWishList(event.productId);
      yield UpdatedWishList(state.data);
    }
  }
}
