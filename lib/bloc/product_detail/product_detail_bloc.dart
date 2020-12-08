import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:living_desire/DBHandler/DBHandler.dart';
import 'package:living_desire/models/product_variants.dart';
import 'package:living_desire/models/products.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  ProductDetailBloc() : super(ProductDetailInitial());

  @override
  Stream<ProductDetailState> mapEventToState(
    ProductDetailEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is LoadProductDetail) {
      yield* loadProductDetail(event);
    }
  }
}

Stream<ProductDetailState> loadProductDetail(LoadProductDetail event) async* {
  Products products = new Products();

  ProductVariants productVariants = new ProductVariants(
    manufacturingPrice: 25.0,
    sellingPrice: 100.0,
    discountPrice: 10.0,
    size: "small",
    colour: "Blue",
    productID: "ProductID",
    variantID: "VariantID",
    isAvailable: true,
    images: [
      "https://ii2.pepperfry.com/media/catalog/product/x/l/236x260/xl-[kids]-classic-leatherette-kids-filled-bean-bag-in-brown-colour-by-can-xl-[kids]-classic-leathere-ecw5ij.jpg",
      "https://ii2.pepperfry.com/media/catalog/product/x/l/236x260/xl-[kids]-classic-leatherette-kids-filled-bean-bag-in-brown-colour-by-can-xl-[kids]-classic-leathere-ecw5ij.jpg",
      "https://ii1.pepperfry.com/media/catalog/product/c/l/236x260/classic-style-xxxl-bean-bag-filled-with-beans-in-neon-green-colour-by-sattva-classic-style-xxxl-bean-ojqije.jpg"
    ],
  );

  yield ProductDetailLoading();

  try {
    await Future.delayed(Duration(seconds: 2));

    yield ProductDetailLoadingSuccessful(products, productVariants);
  } catch (e) {
    yield ProductDetailLoadingFailure();
  }
}
