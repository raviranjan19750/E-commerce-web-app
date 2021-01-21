import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/bloc/wishlist_config/wishlist_bloc.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository wishlistRepository;
  final WishlistConfigBloc configBloc;
  WishlistBloc({this.wishlistRepository, this.configBloc})
      : super(WishlistDetailInitial());

  @override
  Stream<WishlistState> mapEventToState(
    WishlistEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllWishlist) {
      yield* loadWishlistDetail(event);
    } else if (event is DeleteWishlist) {
      yield* deleteWishlistDetail(event);
    }
  }

  // Load Wishlist Detail
  Stream<WishlistState> loadWishlistDetail(LoadAllWishlist event) async* {
    yield WishlistDetailLoading();

    try {
      List<Wishlist> wishlist =
          await wishlistRepository.getWishlistDetails(event.authID);
      configBloc.add(UpdateWishList(wishlist));
      yield WishlistDetailLoadingSuccessful(wishlist);
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield WishlistDetailLoadingFailure();
    }
  }

  // TODO: Make Wishlist add to cart function:
  //To add wishlist to the cart: cartrepository.addCartDetails then
  // Delete Wishlist: remove from cart

  // Add Wishlist Detail
  Stream<WishlistState> addWishlistDetail(AddWishlist event) async* {
    yield AddWishlistDetailLoading();

    try {
      await wishlistRepository.addWishlistDetails(
        event.authID,
        event.productID,
        event.variantID,
      );

      yield AddWishlistDetailLoadingSuccessful();
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield AddWishlistDetailLoadingFailure();
    }
  }

  //Delete a wishlist
  Stream<WishlistState> deleteWishlistDetail(DeleteWishlist event) async* {
    yield DeleteWishlistDetailLoading();

    try {
      await wishlistRepository.deleteWishlistDetails(
        event.key,
        event.productID,
        event.authID,
      );

      yield* loadWishlistDetail(LoadAllWishlist(event.authID));
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield DeleteWishlistDetailLoadingFailure();
    }
  }
}
