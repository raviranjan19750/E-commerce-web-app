import 'package:living_desire/models/models.dart';

class CustomerDetailRepository {
  List<String> _wishListIds = List();
  List<Cart> _cartItem = List();
  List<String> _cartListIDs = List();
  Set<String> _wishlistSet = Set();
  //List<Product> _cartItem = List();

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
