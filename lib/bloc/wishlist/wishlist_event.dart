part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class InitializeLoadingWishlist extends WishlistEvent {}

class LoadAllWishlist extends WishlistEvent {
  final String authID;

  LoadAllWishlist(
    this.authID,
  );
}
