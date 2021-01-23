import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/cart.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:hive/hive.dart';
import 'package:living_desire/models/localNormalCart.dart';
import 'package:living_desire/models/localwishlist.dart';
import 'package:living_desire/models/models.dart';

class CustomCartLocalStorage {
  final BulkOrderCart itm;

  CustomCartLocalStorage({this.itm});

  void saveToLocalStorage() {
    final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');
    // _cartlist.put(widget.variantID, {

    // });
    _customcartlist.put(
        itm.key,
        CustomCartLocal(
            key: itm.key,
            productId: itm.productID,
            variantId: itm.variantID,
            quantity: itm.quantity,
            colour: itm.colour,
            description: itm.description,
            images: itm.images,
            productSubType: itm.productSubType,
            productType: itm.productType,
            size: itm.size));
  }

  void deleteFromLocalStorage(String key) {
    final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');
    _customcartlist.delete(key);
  }

  void deleteAll() {
    final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');
    _customcartlist.deleteFromDisk();
  }
}

class NormalLocalStorage {
  final Cart itm;

  NormalLocalStorage(this.itm);

  void saveToLocalStorage() {
    final _cartlist = Hive.box<NormalCartLocal>('cart_items');

    _cartlist.put(
        itm.key,
        NormalCartLocal(
          key: itm.key,
          productID: itm.productID,
          variantID: itm.variantID,
          quantity: itm.quantity,
        ));
  }

  void deleteFromLocalStorage(String itemKey) {
    final _cartlist = Hive.box<NormalCartLocal>('cart_items');
    var cart = _cartlist.toMap();
    cart.forEach((key, value) {
      if (key == itemKey) {
        _cartlist.delete(key);
      }
    });
  }

  void changeQuantityFromLocalStorage(String itemKey, int quantity) {
    final _cartlist = Hive.box<NormalCartLocal>('cart_items');
    var cart = _cartlist.toMap();

    cart.forEach((key, value) {
      if (key == itemKey) {
        NormalCartLocal item = _cartlist.get(key);
        item.quantity = quantity;
      }
    });
  }

  void deleteAll() {
    final _customcartlist = Hive.box<NormalCartLocal>('cart_items');
    _customcartlist.deleteFromDisk();
  }
}

class WishlistLocalStorage {
  final Wishlist itm;

  WishlistLocalStorage(this.itm);
  void saveToLocalStorage() {
    final _cartlist = Hive.box<WishlistLocal>('wishlist_items');

    _cartlist.put(
        itm.key,
        WishlistLocal(
          key: itm.key,
          productID: itm.productID,
          variantID: itm.variantID,
        ));
  }

  void deleteFromLocalStorage(String key) {
    final _customcartlist = Hive.box<WishlistLocal>('wishlist_items');
    _customcartlist.delete(key);
  }

  void deleteAll() {
    final _customcartlist = Hive.box<WishlistLocal>('wishlist_items');
    _customcartlist.deleteFromDisk();
  }
}
