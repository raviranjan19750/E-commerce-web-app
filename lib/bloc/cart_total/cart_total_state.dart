part of 'cart_total_bloc.dart';

enum CartTotalStateType { INITIAL, LOADING, UPDATING, SUCCESS, FAILURE }

abstract class CartTotalState {
  //final List<Cart> cart;
  final double subTotal;
  // final CartItemStateType type;

  CartTotalState(
    this.subTotal,
  );
}

class CartTotalInitial extends CartTotalState {
  CartTotalInitial() : super(0.0);
  // //List<Cart> cart,
  // //double subTotal)
  // : super(
  //     subTotal,
  //   );
}

class CartTotalUpdateInitial extends CartTotalState {
  CartTotalUpdateInitial(double subTotal) : super(subTotal);
}

class CartTotalUpdateFailure extends CartTotalState {
  CartTotalUpdateFailure(double subTotal) : super(subTotal);
}

class CartTotalUpdate extends CartTotalState {
  CartTotalUpdate(double subTotal)
      : super(
          subTotal,
        );
}
