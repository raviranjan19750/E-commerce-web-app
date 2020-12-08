part of 'wishlist_bloc.dart';

abstract class WishlistState {}

class WishlistDetailInitial extends WishlistState {}

class WishlistDetailLoading extends WishlistState {}

// ignore: must_be_immutable
class WishlistDetailLoadingSuccessful extends WishlistState {
  final List<Wishlist> wishlist;

  WishlistDetailLoadingSuccessful(this.wishlist);
}

class WishlistDetailLoadingFailure extends WishlistState {}
