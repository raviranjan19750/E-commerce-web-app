import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:living_desire/bloc/bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';
import 'package:living_desire/config/CloudFunctionConfig.dart';
import 'package:living_desire/models/localNormalCart.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
import 'package:hive/hive.dart';

import '../../logger.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  final CustomerDetailRepository customerRepo;
  final CartItemBloc cartItemBloc;

  var LOG = LogBuilder.getLogger();

  CartBloc({
    this.cartRepository,
    this.customerRepo,
    this.cartItemBloc,
  }) :
        // assert(customerRepo != null),
        //       assert(cartRepository != null),
        //       assert(cartItemBloc != null),
        super(CartDetailInitial(cartRepository.cart));

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllCart) {
      yield* loadCartDetail(event);
    } else if (event is DeleteCart) {
      //customerRepo.removeFromCart(cart.key);
      yield* deleteCartDetail(event);
    } else if (event is ChangeQuantityCart) {
      yield* changeQuantityCartDetail(event);
    } else if (event is AddCart) {
      //customerRepo.addToCart(cart.key);
      yield* addCartDetail(event);
    } else if (event is RefreshCart) {
      yield CartDetailLoading();
      await Future.delayed(Duration(milliseconds: 200));
      LOG.i('Total Items Length ${cartRepository.cart.length}');
      yield CartDetailLoadingSuccessful(
          cartRepository.cart.map((e) => e).toList());
    }
  }

  // Load All Cart Detail
  Stream<CartState> loadCartDetail(LoadAllCart event) async* {
    yield CartDetailLoading();

    try {
      if (event.authID != null) {
        List<Cart> cart = await cartRepository.getCartDetails(event.authID);
        //print('got list of cart');

        //customerRepo.addAllCartList(cart);
        yield CartDetailLoadingSuccessful(cart);
      } else {
        final _cartlist = Hive.box<NormalCartLocal>('cart_items');
        Map<dynamic, NormalCartLocal> cartMap = _cartlist.toMap();
        var data = [];
        var keys = [];
        cartMap.forEach((key, value) {
          var keyData = {
            "key": key,
            "variantID": value.variantID,
          };
          keys.add(keyData);
          var cartData = {
            "productID": value.productID,
            "variantID": value.variantID,
            "quantity": value.quantity
          };
          data.add(cartData);
        });

        List<Cart> cart = [];
        var response = await CloudFunctionConfig.post(
            'manageAnonymousUser/get-normal-cart', data);
        if (response.statusCode == 200) {
          cart = (jsonDecode(response.body) as List).map((e) {
            for (int i = 0; i < keys.length; i++) {
              if (e['variantID'] == (keys[i])["variantID"]) {
                return Cart.fromJsonMap(e, (keys[i])["key"]);
              }
            }
          }).toList();

          cartRepository.addCartLocalData(cart);
          yield CartDetailLoadingSuccessful(cart);
        }
      }
    } catch (e) {
      yield CartDetailLoadingFailure();
    }
  }

  static const AUTO_ID_ALPHABET =
      'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
  static const AUTO_ID_LENGTH = 20;
  String _getAutoId() {
    final buffer = StringBuffer();
    final random = Random.secure();

    final maxRandom = AUTO_ID_ALPHABET.length;

    for (int i = 0; i < AUTO_ID_LENGTH; i++) {
      buffer.write(AUTO_ID_ALPHABET[random.nextInt(maxRandom)]);
    }
    return buffer.toString();
  }

  // Add a Cart Detail
  Stream<CartState> addCartDetail(AddCart event) async* {
    yield CartDetailLoading();

    try {
      if (event.authID != null) {
        await cartRepository.addCartDetails(
          event.authID,
          event.productID,
          event.variantID,
          event.quantity,
        );

        yield AddCartDetailLoadingSuccessful();
      } else {
        final _cartlist = Hive.box<NormalCartLocal>('cart_items');
        Map<dynamic, NormalCartLocal> cartMap = _cartlist.toMap();
        Cart itm = new Cart(
          key: _getAutoId(),
          productID: event.productID,
          variantID: event.variantID,
          quantity: event.quantity,
        );
        bool isInCart = false;
        String existingCartKey;
        int newQuantity;
        cartMap.forEach((key, value) {
          if (value.variantID == itm.variantID) {
            isInCart = true;
            existingCartKey = key;
            newQuantity = value.quantity + event.quantity;
          }
        });
        if (isInCart == false) {
          NormalLocalStorage(itm).saveToLocalStorage();
        } else {
          NormalLocalStorage(itm)
              .changeQuantityFromLocalStorage(existingCartKey, newQuantity);
        }
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield AddCartDetailLoadingFailure();
    }
  }

  // Delete a Cart Detail
  Stream<CartState> deleteCartDetail(DeleteCart event) async* {
    yield DeleteCartDetailLoading();

    try {
      if (event.authID != null) {
        await cartRepository.deleteCartDetails(
          authID: event.authID,
          productID: event.productID,
          key: event.key,
        );

        yield* loadCartDetail(LoadAllCart(event.authID));
      } else {
        Cart itm = new Cart(
          productID: event.productID,
        );
        NormalLocalStorage(itm).deleteFromLocalStorage(itm.productID);
        yield* loadCartDetail(LoadAllCart(event.authID));
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield DeleteCartDetailLoadingFailure();
    }
  }

  // Change quantity of a Cart Detail
  Stream<CartState> changeQuantityCartDetail(ChangeQuantityCart event) async* {
    try {
      if (event.authID != null) {
        yield PrdouctCardViewState(type: PrdouctCardViewType.LOADING);
        // await Future.delayed(Duration(seconds: 2));
        await cartRepository.changeQuantityCartDetails(
          event.key,
          event.quantity,
        );
        // Manupuating the card result
        if (state.cart != null) {
          int len = state.cart.length;
          for (int i = 0; i < len; i++) {
            if (state.cart[i].key == event.key) {
              state.cart[i].quantity = event.quantity;
            }
          }
          yield PrdouctCardViewState(
              cart: state.cart,
              key: event.key,
              type: PrdouctCardViewType.SUCCESS);
        }
      } else {
        yield PrdouctCardViewState(type: PrdouctCardViewType.LOADING);

        // Cart itm= new Cart(
        //     productID:event.productID,
        //     quantity: event.quantity,
        //   );
        //NormalLocalStorage(itm).changeQuantityFromLocalStorage(itm.productID, itm.quantity);
      }
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield ChangeQuantityCartDetailLoadingFailure();
    }
  }
}
