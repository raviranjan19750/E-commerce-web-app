import 'package:living_desire/data/data.dart';
import 'package:living_desire/models/models.dart';

class CustomerDetailRepository {
  List<String> _wishListIds = List();
  List<Cart> _cartItem = List();
  List<String> _cartListIDs = List();

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

  void addAllCartList(List<Cart> cart) {
    _cartItem = cart;
  }

  void addToCart(String id) {
    _cartListIDs.add(id);
  }

  void removeFromCart(String id) {
    _cartListIDs.remove(id);
  }

  void onChangeQuantityCart(
    String id,
    int quantity,
  ) {
    for (int i = 0; i < _cartItem.length; i++) {
      if (_cartItem[i].key == id) {
        _cartItem[i].quantity = quantity;
      }
    }
  }

  get cartTotal {
    double total = 0;
    _cartItem.forEach((element) {
      total = total + element.discountPrice * element.quantity;
    });
    return total;
  }
}
