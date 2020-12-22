import 'package:living_desire/models/models.dart';

class CustomerDetailRepository {
  Set<String> _wishlistSet = Set();
  List<Product> _cartItem = List();

  void addToWishList(String id) {
    _wishlistSet.add(id);
  }

  void removeFromWishList(String id) {
    _wishlistSet.remove(id);
  }

  bool contains(String id) {
    return _wishlistSet.contains(id);
  }

  get totalItemInCart {
    return _wishlistSet.length;
  }
}