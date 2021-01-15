import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:elastic_client/elastic_client.dart';
import 'package:http/http.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/comboProduct.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productRepository;
  var LOG = LogBuilder.getLogger();

  var logger = LogBuilder.getLogger();
  SearchApi searchApi = new SearchApi();

  ProductDetailBloc({this.productRepository})
      : assert(productRepository != null),
        super(ProductDetailInitial());

  @override
  Stream<ProductDetailState> mapEventToState(
    ProductDetailEvent event,
  ) async* {
    if (event is LoadProductDetail) {
      yield* loadProductDetail(event);
    } else if (event is LoadComboProductDetail) {
      yield* loadComboProductDetail(event);
    }else if(event is LoadSizeChart) {
      yield* loadSizeChart(event);
    }
  }

  Stream<ProductDetailState> loadProductDetail(LoadProductDetail event) async* {
    yield ProductDetailLoading();
    try {
      var productDescription =
          await productRepository.getProductVariantDescription(productID: event.productID, variantID: event.variantID, authID: event.authID);
      yield ProductDetailLoadingSuccessful(productDescription);
    } catch (e) {
      print(e.toString());
      yield ProductDetailLoadingFailure();
    }
  }

  Stream<ProductDetailState> loadComboProductDetail(
      LoadComboProductDetail event) async* {
    yield ProductDetailLoading();
    try {
      var comboProductDescription = await productRepository.getComboProductDescription(productID: event.productID, authID: event.authID);
      yield ComboProductDetailLoadingSuccessful(comboProductDescription);
    } catch (e) {
      print(e.toString());
      yield ProductDetailLoadingFailure();
    }
  }

  Stream<ProductDetailState> loadSizeChart(LoadSizeChart event) async* {

    yield SizeChartLoading();

   /* try {
    //  var sizeChart = await productRepository.getSizeChart(type: event.type, subType: event.subType);
      print("size Chart data Bloc " + sizeChart.toString());
      yield SizeChartLoadingSuccessful(sizeChart);
    } catch (e) {
      print(e.toString());
      yield SizeChartLoadingFailure();
    }*/

  }

}
