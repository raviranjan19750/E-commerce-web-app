import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/DBHandler/ProductRepository.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/CheckProductAvailability.dart';
import 'package:living_desire/models/ProductDetail.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/models/product_variants.dart';
import 'package:living_desire/models/products.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';

part 'product_detail_event.dart';

part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {

  final ProductRepository productRepository;

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
    } else if (event is LoadProductVariantDetail) {
      yield* loadProductVariantDetail(event);
    }
  }

  Stream<ProductDetailState> loadProductDetail(LoadProductDetail event) async* {
    yield ProductDetailLoading();

    try {

      var productDescription = await productRepository.getProductVariantDescription(productID: event.productID, variantID: event.variantID);
      yield ProductDetailLoadingSuccessful(productDescription);

    /*  SearchResult searchResult = await searchApi.getSimilarProduct();
      var similarSearchResult = getSimilarProductData(searchResult);
      yield SimilarProductDetailLoadingSuccessful(similarSearchResult);*/
      // var availability = await productRepository.checkProductAvailability(pincode: "110042", productID: "0IeSrbsqqxiqwELq4Qqm", warehouseID: "temp_id");

    } catch (e) {
      print(e.toString());
      yield ProductDetailLoadingFailure();
    }
  }

  Stream<ProductDetailState> loadProductVariantDetail(
      LoadProductVariantDetail event) async* {
    yield ProductDetailLoading();

    try {
      var productImageSizeDescription = await productRepository.getProductVariantSizeColorDescription(productID: event.productID, color: event.color, size: event.size);
      yield ProductDetailLoadingSuccessful(productImageSizeDescription);

    } catch (e) {
      print(e.toString());
      yield ProductDetailLoadingFailure();
    }
  }

  List<Product> getSimilarProductData(SearchResult searchResult) {

    final hits = searchResult.hits;
    print("inside function");


    int len = hits.length;
    print(len);

    List<Product> result = List();
    for (int x = 0; x < len; x++) {
      Doc hit = hits[x];
      print(hit.doc.toString());

      List<String> imgUrls = List();
      for (var img in hit.doc['images']) {
        imgUrls.add(img.toString());
      }

      List<String> colors = List();
      for (var col in hit.doc['colour']) {
        colors.add(col['hexCode'].toString());
      }

      Set<String> tags = HashSet();
      for (var tag in hit.doc['tags']) {
        tags.add(tag.toString());
      }
      var prod = Product(
          title: hit.doc['name'],
          color: colors,
          imageUrls: imgUrls,
          size: hit.doc['size'],
          discountPrice: hit.doc['discountPrice'],
          retailPrice: hit.doc['sellingPrice'],
          productId: hit.doc['productID'],
          varientId: hit.doc['variantID'],
          tags: tags,
          type: hit.doc['type'],
          isAvailable: hit.doc['isAvailable'],
          subType: hit.doc['subType']);
      result.add(prod);
    }
    List<Product> finalResult = List();
    finalResult.addAll(result);

    return finalResult;


  }




}
