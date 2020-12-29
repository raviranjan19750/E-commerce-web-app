import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:meta/meta.dart';

part 'product_availability_event.dart';
part 'product_availability_state.dart';

class ProductAvailabilityBloc
    extends Bloc<ProductAvailabilityEvent, ProductAvailabilityState> {
  final ProductRepository productRepository;

  ProductAvailabilityBloc({this.productRepository})
      : assert(productRepository != null),
        super(ProductAvailabilityInitial());

  @override
  Stream<ProductAvailabilityState> mapEventToState(
    ProductAvailabilityEvent event,
  ) async* {
    if (event is CheckingProductAvailability) yield* checkAvailability(event);
  }

  Stream<ProductAvailabilityState> checkAvailability(
      CheckingProductAvailability event) async* {
    yield ProductDetailAvailabilityChecking();

    try {
      var productAvailabilityResponse =
          await productRepository.checkProductAvailability(
              pincode: event.pincode,
              productID: event.productID,
              variantID: event.variantID);
      yield ProductDetailAvailabilityCheckingSuccessful(
          productAvailabilityResponse);
    } catch (e) {
      print(e.toString());
      yield ProductDetailAvailabilityCheckingFailure();
    }
  }
}
