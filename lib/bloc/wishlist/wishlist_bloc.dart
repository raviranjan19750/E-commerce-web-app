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
    }
  }

  Stream<WishlistState> loadWishlistDetail(LoadAllWishlist event) async* {
    yield WishlistDetailLoading();

    try {
      List<Wishlist> wishlist;
      //=await addresssRepository.getAddressDetails(event.authID);

      yield WishlistDetailLoadingSuccessful(wishlist);
    } catch (e) {
      yield WishlistDetailLoadingFailure();
    }
  }
}
