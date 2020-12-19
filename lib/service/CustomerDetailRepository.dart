import 'package:living_desire/models/models.dart';

class CustomerDetailRepository {
  List<String> _wishListIds = List();
  List<Product> _cartItem = List();

  void addToWishList(String id) {
    _wishListIds.add(id);
  }

  void removeFromWishList(String id) {
    _wishListIds.remove(id);
  }

  bool contains(String id) {
    return _wishListIds.contains(id);
  }

  get totalItemInCart {
    return _wishListIds.length;
  }
}