part of 'cart_config_bloc.dart';

@immutable
abstract class CartConfigState {
  final int totalItem;

  CartConfigState(this.totalItem);
}

class CartConfigInitial extends CartConfigState {
  CartConfigInitial(int totalItem) : super(totalItem);
}

class UpdatedCartConfigList extends CartConfigState {
  UpdatedCartConfigList(int totalItem) : super(totalItem);
}

