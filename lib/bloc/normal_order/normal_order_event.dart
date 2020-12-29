part of 'normal_order_bloc.dart';

abstract class NormalOrderEvent {}

class InitializeLoadingNormalOrder extends NormalOrderEvent {}

class LoadAllNormalOrders extends NormalOrderEvent {
  final String authID;

  LoadAllNormalOrders(this.authID);
}

class RefreshOrder extends NormalOrderEvent {}
