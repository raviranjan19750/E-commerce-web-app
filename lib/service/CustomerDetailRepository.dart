
import 'dart:js';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';

enum RepositorySource {
  LOCAL,
  ONLINE
}

class CustomerDetailRepository {

  final WishlistRepository wishlistRepo;
  RepositorySource _source = RepositorySource.LOCAL;

  List<String> _wishListIds = List.empty(growable: true);
  List<Cart> _cartItem = List.empty(growable: true);
  List<String> _cartListIDs = List.empty(growable: true);
  Set<String> _wishlistSet = Set();

  CustomerDetailRepository(this.wishlistRepo);

  void addToWishList(String productId, String variantId, {String authID}) async {
    if (authID != null) {
      if (_source == RepositorySource.LOCAL) {
        _source = RepositorySource.ONLINE;
        List<Wishlist> wish = await wishlistRepo.getWishlistDetails(authID);
        _wishlistSet = Set();
        wish.forEach((element) {
          _wishlistSet.add(element.variantID);
        });
      }
      await wishlistRepo.addWishlistDetails(authID, productId, variantId);
    }
    _wishlistSet.add(variantId);
  }

  Future<List<String>> getWishlist({String authID}) async {
    if (authID != null) {
      if (_source == RepositorySource.LOCAL) {
        _source = RepositorySource.ONLINE;
        _wishlistSet = Set();
        List<Wishlist> wish = await wishlistRepo.getWishlistDetails(authID);
        wish.forEach((element) {
          _wishlistSet.add(element.variantID);
        });
      }
    }
    return _wishlistSet.toList();
  }

  void resetWishList() {
    _source = RepositorySource.LOCAL;
    _wishlistSet = Set();
  }

  void resetWishlistWithData(List<String> data) {
    _wishlistSet = Set.from(data);
  }

  void removeFromWishList(String id) {
    // _wishlistSet.remove(id);
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
