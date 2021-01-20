import 'dart:js';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/models/mini_cart.dart';
import 'package:living_desire/models/models.dart';

enum RepositorySource { LOCAL, ONLINE }

enum CartRepositorySource { LOCAL, ONLINE }

class CustomerDetailRepository {
  final WishlistRepository wishlistRepo;
  final CartRepository cartRepository;
  RepositorySource _source = RepositorySource.LOCAL;
  CartRepositorySource _cartSource = CartRepositorySource.LOCAL;

  Set<String> _wishlistSet = Set();
  Set<MiniCart> _cartSet = Set();

  CustomerDetailRepository({this.wishlistRepo, this.cartRepository});

  Future<void> addToWishList(String productId, String variantId,
      {String authID}) async {
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

  bool alreadyInWishlist(String id) {
    return _wishlistSet.contains(id);
  }

  bool alreadyInCart(String productId, String variantId) {
    _cartSet.forEach((e) {
      if (e.productID.compareTo(productId) == 0 && e.variantID.compareTo(variantId) == 0) {
        return true;
      }
    });
    return false;
  }

  get totalItemInWishList {
    return _wishlistSet.length;
  }

  get totalItemsInCart {
    int quantity = 0;
    _cartSet.forEach((element) { quantity += element.quantity; });
    return quantity;
  }

  void resetCartList() {
    _cartSource = CartRepositorySource.LOCAL;
    _cartSet = Set();
  }

  Future<List<MiniCart>> getAllCartItems({String authID}) async {
    if (authID != null) {
      if (_cartSource == CartRepositorySource.LOCAL) {
        _cartSource = CartRepositorySource.ONLINE;
        _cartSet = Set();
        List<Cart> cartItems = await cartRepository.getCartDetails(authID);
        cartItems.forEach((element) {
          _cartSet.add(MiniCart(element.variantID, element.productID, element.quantity));
        });
      }
    }
    return _cartSet.toList();
  }

  Future<void> addToCart({ String authID, String productID, String variantID, int quantity }) async {
    if (authID != null) {
      await cartRepository.addCartDetails(authID, productID, variantID, quantity);
      _cartSet.add(MiniCart(variantID, productID, quantity));
    }
  }

  // void addAllCartList(List<Cart> cart) {
  //   _cartItem = cart;
  // }
  //
  // void addToCart(String id) {
  //   _cartListIDs.add(id);
  // }
  //
  // void removeFromCart(String id) {
  //   _cartListIDs.remove(id);
  // }
  //
  // void onChangeQuantityCart(
  //   String id,
  //   int quantity,
  // ) {
  //   for (int i = 0; i < _cartItem.length; i++) {
  //     if (_cartItem[i].key == id) {
  //       _cartItem[i].quantity = quantity;
  //     }
  //   }
  // }
  //
  // get cartTotal {
  //   double total = 0;
  //   _cartItem.forEach((element) {
  //     total = total + element.discountPrice * element.quantity;
  //   });
  //   return total;
  // }
}
