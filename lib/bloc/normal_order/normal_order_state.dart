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

class AddRatingNormalOrderDetailLoading extends NormalOrderState {}

class AddRatingNormalOrderDetailSuccessfull extends NormalOrderState {}

class AddRatingNormalOrderDetailFailure extends NormalOrderState {}

class EditRatingNormalOrderDetailLoading extends NormalOrderState {}

class EditRatingNormalOrderDetailSuccessfull extends NormalOrderState {}

class EditRatingNormalOrderDetailFailure extends NormalOrderState {}
