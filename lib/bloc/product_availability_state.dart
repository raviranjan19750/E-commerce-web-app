part of 'product_availability_bloc.dart';

@immutable
abstract class ProductAvailabilityState {}

class ProductAvailabilityInitial extends ProductAvailabilityState {}


class ProductDetailAvailabilityChecking extends ProductAvailabilityState{}

class ProductDetailAvailabilityCheckingSuccessful extends ProductAvailabilityState{

  final CheckProductAvailability checkProductAvailability;

  ProductDetailAvailabilityCheckingSuccessful(this.checkProductAvailability);

}

class ProductDetailAvailabilityCheckingFailure extends ProductAvailabilityState{}