part of 'cart_total_bloc.dart';

enum CartTotalStateType { INITIAL, LOADING, UPDATING, SUCCESS, FAILURE }

abstract class CartTotalState {
  final double discountTotal;
  final double retailTotal;
  final int totalQuantity;

  CartTotalState({
    this.discountTotal,
    this.totalQuantity,
    this.retailTotal,
  })  : assert(discountTotal != null),
        assert(retailTotal != null),
        assert(totalQuantity != null);

  @override
  String toString() {
    return 'CartTotalState{discountTotal: $discountTotal, retailTotal: $retailTotal, totalQuantity: $totalQuantity}';
  }
}

class CartTotalInitial extends CartTotalState {
  CartTotalInitial({
    double discountTotal,
    double retailTotal,
    int totalQuantity,
  }) : super(
            totalQuantity: totalQuantity,
            discountTotal: discountTotal,
            retailTotal: retailTotal);
}

class CartTotalUpdateInitial extends CartTotalState {
  CartTotalUpdateInitial({
    double discountTotal,
    double retailTotal,
    int totalQuantity,
  }) : super(
          totalQuantity: totalQuantity,
          discountTotal: discountTotal,
          retailTotal: retailTotal,
        );
}

class CartTotalUpdateFailure extends CartTotalState {
  CartTotalUpdateFailure({
    double discountTotal,
    double retailTotal,
    int totalQuantity,
  }) : super(
          totalQuantity: totalQuantity,
          discountTotal: discountTotal,
          retailTotal: retailTotal,
        );
}

class CartTotalUpdate extends CartTotalState {
  CartTotalUpdate({
    double discountTotal,
    double retailTotal,
    int totalQuantity,
  }) : super(
          totalQuantity: totalQuantity,
          discountTotal: discountTotal,
          retailTotal: retailTotal,
        );
}
