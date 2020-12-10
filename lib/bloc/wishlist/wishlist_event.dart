part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistEvent {}

class AddToWishList extends WishlistEvent {
  final String productId;

  AddToWishList(this.productId);
}

class RemoveFromWishList extends WishlistEvent {
  final String productId;

  RemoveFromWishList(this.productId);
}

class GetAllWishListProduct extends WishlistEvent {


}
