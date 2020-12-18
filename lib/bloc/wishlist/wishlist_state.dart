part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {
  final int totalItem;

  WishlistState(this.totalItem);
}

class WishlistInitial extends WishlistState {
  WishlistInitial(int totalItem) : super(totalItem);
}

class UpdatedWishList extends WishlistState {
  UpdatedWishList(int totalItem) : super(totalItem);
}
