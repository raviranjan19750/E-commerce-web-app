part of 'wishlist_bloc.dart';

@immutable
abstract class WishlistState {
  final List<String> data;

  WishlistState(this.data);

  List<String> addToWishList(String id) {
    data.add(id);
    return data;
  }

  List<String> removeFromWishList(String id) {
    data.remove(id);
    return data;
  }

  bool contains(String id) {
    return data.contains(id);
  }
}

class WishlistInitial extends WishlistState {
  WishlistInitial(List<String> data) : super(data);
}

class UpdatedWishList extends WishlistState {
  UpdatedWishList(List<String> data) : super(data);
}
