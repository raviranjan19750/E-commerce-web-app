import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:living_desire/bloc/cart_item/bloc/cart_item_bloc.dart';
import 'package:living_desire/service/CustomerDetailRepository.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;

  final CustomerDetailRepository customerRepo;
  final CartItemBloc cartItemBloc;
  CartBloc({
    this.cartRepository,
    this.customerRepo,
    this.cartItemBloc,
  }) :
        // assert(customerRepo != null),
        //       assert(cartRepository != null),
        //       assert(cartItemBloc != null),
        super(CartDetailInitial(List()));

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
    }
  }

  // Load All Cart Detail
  Stream<CartState> loadCartDetail(LoadAllCart event) async* {
    yield CartDetailLoading();

    try {
      List<Cart> cart = await cartRepository.getCartDetails(event.authID);
      customerRepo.addAllCartList(cart);
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
    } catch (e) {
      yield AddCartDetailLoadingFailure();
    }
  }

  // Delete a Cart Detail
  Stream<CartState> deleteCartDetail(DeleteCart event) async* {
    yield DeleteCartDetailLoading();

    try {
      await cartRepository.deleteCartDetails(event.key);

      yield* loadCartDetail(LoadAllCart(event.authID));
    } catch (e) {
      yield DeleteCartDetailLoadingFailure();
    }
  }

  // Change quantity of a Cart Detail
  Stream<CartState> changeQuantityCartDetail(ChangeQuantityCart event) async* {
    try {
      yield PrdouctCardViewState(type: PrdouctCardViewType.LOADING);
      await Future.delayed(Duration(seconds: 2));
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
    } catch (e) {
      yield ChangeQuantityCartDetailLoadingFailure();
    }
  }
}
