part of 'product_availability_bloc.dart';

@immutable
abstract class ProductAvailabilityEvent {}

class CheckingProductAvailabilityInitial extends ProductAvailabilityEvent{


  CheckingProductAvailabilityInitial();

}

class CheckingProductAvailability extends ProductAvailabilityEvent{

  final String productID;
  final String wareHouseID;
  final String pincode;

  CheckingProductAvailability(this.productID, this.wareHouseID, this.pincode);

}