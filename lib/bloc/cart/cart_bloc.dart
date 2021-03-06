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
    }
    // else if (event is DeleteCart) {
    //   //customerRepo.removeFromCart(cart.key);
    //   yield* deleteCartDetail(event);
    // } else if (event is ChangeQuantityCart) {
    //   yield* changeQuantityCartDetail(event);
    // }
    else if (event is AddCart) {
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
      List<Cart> cart = await cartRepository.getCartDetails(event.authID);
      //print('got list of cart');

      //customerRepo.addAllCartList(cart);
      yield CartDetailLoadingSuccessful(cart);
    } catch (e) {
      yield CartDetailLoadingFailure();
    }
  }

  // Add a Cart Detail
  Stream<CartState> addCartDetail(AddCart event) async* {
    yield CartDetailLoading();

    try {
      await cartRepository.addCartDetails(
        event.authID,
        event.productID,
        event.variantID,
        event.quantity,
      );

      yield AddCartDetailLoadingSuccessful();
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);

      yield AddCartDetailLoadingFailure();
    }
  }
}
