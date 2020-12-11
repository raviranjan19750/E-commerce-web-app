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

class AddWishlistDetailLoading extends WishlistState {}

class AddWishlistDetailLoadingSuccessful extends WishlistState {}

class AddWishlistDetailLoadingFailure extends WishlistState {}

class DeleteWishlistDetailLoading extends WishlistState {}

class DeleteWishlistDetailLoadingSuccessful extends WishlistState {}

class DeleteWishlistDetailLoadingFailure extends WishlistState {}
