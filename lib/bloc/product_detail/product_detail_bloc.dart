import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/product_variants.dart';
import 'package:living_desire/models/products.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final ProductRepository productRepository;


  ProductDetailBloc({this.productRepository})
      : assert(productRepository != null),
        super(ProductDetailInitial());

  @override
  Stream<ProductDetailState> mapEventToState(
    ProductDetailEvent event,
  ) async* {
    if (event is LoadProductDetail) {
      yield* loadProductDetail(event);
    }else if (event is LoadProductVariantDetail) {
      yield* loadProductVariantDetail(event);
    }
  }

  Stream<ProductDetailState> loadProductDetail(LoadProductDetail event) async* {
    yield ProductDetailLoading();

    try {
      var productDescription = await productRepository.getProductVariantDescription(productID:"0Kw7a5E2AMQ8jJM6a7C0", variantID: "02nnXgCzOjVHRarIPIrf");
     // var availability = await productRepository.checkProductAvailability(pincode: "110042", productID: "0IeSrbsqqxiqwELq4Qqm", warehouseID: "temp_id");
      yield ProductDetailLoadingSuccessful(productDescription);

    } catch (e) {
      print(e.toString());
      yield ProductDetailLoadingFailure();
    }
  }

  Stream<ProductDetailState> loadProductVariantDetail(LoadProductVariantDetail event) async* {
    yield ProductDetailLoading();

    try{
      var productImageSizeDescription = await productRepository.getProductVariantSizeColorDescription(productID: "0IeSrbsqqxiqwELq4Qqm", color: "Blue", size: "XXL");
      yield ProductDetailLoadingSuccessful(productImageSizeDescription);
    }catch(e) {
      print(e.toString());
      yield ProductDetailLoadingFailure();
    }

  }


}












