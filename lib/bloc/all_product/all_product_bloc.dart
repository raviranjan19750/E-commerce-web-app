import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {

  final SearchApi searchApi;

  AllProductBloc({@required this.searchApi}) :
        assert(searchApi != null),
        super(AllProductInitial());

  @override
  Stream<AllProductState> mapEventToState(
    AllProductEvent event,
  ) async* {
    if (event is InitializeLoadingProduct) {
      yield* _mapLoadingAllProduct();
    } else if (event is LoadAllProductWithSearchParams) {
      yield* _mapLoadingFilteredProduct(event);
    }
  }

  Stream<AllProductState> _mapLoadingAllProduct() async* {
    yield LoadingAllProduct();
    try {
      // searchApi
      final product = await searchApi.getAllProducts();
      yield SuccessLoadingAllProduct(product);
    } catch (e) {
      yield FailureLoadingProduct();
    }
  }

  Stream<AllProductState> _mapLoadingFilteredProduct(LoadAllProductWithSearchParams event) async* {
    yield LoadingAllProduct();
    try {
      // searchApi
      var product;
      if (event.filterText != null && event.filterText.isNotEmpty) {
        product = await searchApi.getFilteredProduct(event.filterText);
      } else {
        product = await searchApi.getAllProducts();
      }
      yield SuccessLoadingAllProduct(product);
    } catch (e) {
      yield FailureLoadingProduct();
    }
  }
}
