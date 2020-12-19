part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistConfigState {
  final int totalItem;

  WishlistConfigState(this.totalItem);
}

class WishlistConfigInitial extends WishlistConfigState {
  WishlistConfigInitial(int totalItem) : super(totalItem);
}

class UpdatedWishConfigList extends WishlistConfigState {
  UpdatedWishConfigList(int totalItem) : super(totalItem);
}
