part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistConfigEvent {}

class UpdateWishConfigList extends WishlistConfigEvent {}

class GetWishlistFromServer extends WishlistConfigEvent {
  final String uid;

  GetWishlistFromServer(this.uid);
}

class UpdateWishList extends WishlistConfigEvent {
  final List<Wishlist> wishlist;

  UpdateWishList(this.wishlist);
}

class ResetWishList extends WishlistConfigEvent {}

