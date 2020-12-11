import 'package:bloc/bloc.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
part 'wishlist_event.dart';
part 'wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  final WishlistRepository wishlistRepository;
  WishlistBloc({this.wishlistRepository}) : super(WishlistDetailInitial());

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

      yield WishlistDetailLoadingSuccessful(wishlist);
    } catch (e) {
      yield WishlistDetailLoadingFailure();
    }
  }

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
    } catch (e) {
      yield AddWishlistDetailLoadingFailure();
    }
  }

  //Delete a wishlist
  Stream<WishlistState> deleteWishlistDetail(DeleteWishlist event) async* {
    yield DeleteWishlistDetailLoading();

    try {
      await wishlistRepository.deleteWishlistDetails(
        event.key,
      );

      yield* loadWishlistDetail(LoadAllWishlist(event.authID));
    } catch (e) {
      yield DeleteWishlistDetailLoadingFailure();
    }
  }
}
