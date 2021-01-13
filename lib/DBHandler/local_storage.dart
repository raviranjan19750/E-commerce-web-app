import 'package:living_desire/models/BulkOrderCart.dart';
import 'package:living_desire/models/cart.dart';
import 'package:living_desire/models/localCustomCart.dart';
import 'package:hive/hive.dart';
import 'package:living_desire/models/localNormalCart.dart';

class CustomCartLocalStorage {
  final BulkOrderCart itm;

  CustomCartLocalStorage({this.itm});

  void saveToLocalStorage() {
    final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');
    // _cartlist.put(widget.variantID, {

    // });
    _customcartlist.put(itm.key, CustomCartLocal(
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

  void deleteFromLocalStorage(String key){
    final _customcartlist = Hive.box<CustomCartLocal>('custom_cart_items');
    _customcartlist.delete(key);
  }

  void deleteAll(){
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
        itm.variantID,
        NormalCartLocal(
          productId: itm.productID,
          variantId: itm.variantID,
          quantity: itm.quantity,
        ));
  }
}
