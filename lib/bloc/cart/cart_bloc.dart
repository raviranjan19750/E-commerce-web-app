import 'package:bloc/bloc.dart';
import '../../DBHandler/DBHandler.dart';
import 'package:living_desire/models/models.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository;
  CartBloc({this.cartRepository}) : super(CartDetailInitial(List()));

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadAllCart) {
      yield* loadCartDetail(event);
    } else if (event is DeleteCart) {
      yield* deleteCartDetail(event);
    } else if (event is ChangeQuantityCart) {
      yield* changeQuantityCartDetail(event);
    } else if (event is AddCart) {
      yield* addCartDetail(event);
    }
  }

  // Load All Cart Detail
  Stream<CartState> loadCartDetail(LoadAllCart event) async* {
    yield CartDetailLoading();

    try {
      List<Cart> cart = await cartRepository.getCartDetails(event.authID);

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
      await cartRepository.changeQuantityCartDetails(
        event.key,
        event.quantity,
      );

      yield* loadCartDetail(LoadAllCart(event.authID));
    } catch (e) {
      yield ChangeQuantityCartDetailLoadingFailure();
    }
  }
}
