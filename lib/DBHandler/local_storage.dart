import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/cart.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:hive/hive.dart';

class CustomCartLocalStorage {
  final BulkOrderCart itm;

  CustomCartLocalStorage(this.itm);

  void saveToLocalStorage() {
    final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');
    // _cartlist.put(widget.variantID, {

    // });
    _customcartlist.put(
        itm.variantID,
        CustomCartLocal(
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
}

class NormalLocalStorage {
  final Cart itm;

  NormalLocalStorage(this.itm);

  void saveToLocalStorage() {
    final _cartlist = Hive.box<CustomCartLocal>('cart_items');
    // _cartlist.put(widget.variantID, {

    // });
    _cartlist.put(
        itm.variantID,
        CustomCartLocal(
          productId: itm.productID,
          variantId: itm.variantID,
          quantity: itm.quantity,
        ));
  }
}
