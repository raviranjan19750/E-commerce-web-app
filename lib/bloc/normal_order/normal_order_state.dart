part of 'normal_order_bloc.dart';

abstract class NormalOrderState {}

class NormalorderDetailInitial extends NormalOrderState {}

class NormalOrderDetailLoading extends NormalOrderState {}

// ignore: must_be_immutable
class NormalOrderDetailLoadingSuccessful extends NormalOrderState {
  final List<Order> order;

  NormalOrderDetailLoadingSuccessful(this.order);
}

class NormalOrderDetailLoadingFailure extends NormalOrderState {}
