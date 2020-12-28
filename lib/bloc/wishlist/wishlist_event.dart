part of 'wishlist_bloc.dart';

abstract class WishlistEvent {}

class InitializeLoadingWishlist extends WishlistEvent {}

class LoadAllWishlist extends WishlistEvent {
  final String authID;

  LoadAllWishlist(
    this.authID,
  );
}

class AddWishlist extends WishlistEvent {
  final String authID;
  final String productID;
  final String variantID;

  AddWishlist({
    this.authID,
    this.productID,
    this.variantID,
  });
}

class DeleteWishlist extends WishlistEvent {
  final String key;
  final String authID;
  final String productID;

  DeleteWishlist({
    this.key,
    this.productID,
    this.authID,
  });
}
