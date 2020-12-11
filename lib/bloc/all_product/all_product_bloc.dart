import 'dart:async';

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
    } else if (event is LoadNextProduct) {
      yield* _mapLoadNextProduct(state, event);
    }
  }


  Stream<AllProductState> _mapLoadNextProduct(AllProductState state, LoadNextProduct event) async* {
    yield LoadingNextProduct();
    if (state is SuccessLoadingAllProduct) {
       final List<Product> previousList = state.productList;
       int limit = state.limit;
       int offset = state.offset + limit;
       List<Product> newProduct = await searchApi.getAllProducts(limit: limit, offset: offset);
       List<Product> finalList = List();
       finalList.addAll(previousList);
       finalList.addAll(newProduct);
       // print(finalList);
       yield SuccessLoadingAllProduct(finalList, limit: limit, offset: offset);
    }
  }


  Stream<AllProductState> _mapLoadingAllProduct() async* {
    yield LoadingAllProduct();
    try {
      // searchApi
      // await Future.delayed(Duration(seconds: 5));
      final product = await searchApi.getAllProducts(offset: 0, limit: 20);
      yield SuccessLoadingAllProduct(product, limit: 20, offset: 0);
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
        product = await searchApi.getFilteredProduct(event.filterText, offset: 0, limit: 20);
      } else {
        product = await searchApi.getAllProducts(limit: 20, offset: 0);
      }
      yield SuccessLoadingAllProduct(product, offset: 0, limit: 20);
    } catch (e) {
      yield FailureLoadingProduct();
    }
  }
}
