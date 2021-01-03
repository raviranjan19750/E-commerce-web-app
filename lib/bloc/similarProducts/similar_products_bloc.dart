import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/models/comboProduct.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';

import '../../logger.dart';

part 'similar_products_event.dart';

part 'similar_products_state.dart';

class SimilarProductsBloc
    extends Bloc<SimilarProductsEvent, SimilarProductsState> {
  var LOG = LogBuilder.getLogger();

  SimilarProductsBloc({this.searchApi}) : super(SimilarProductsInitial());

  final SearchApi searchApi;

  @override
  Stream<SimilarProductsState> mapEventToState(
    SimilarProductsEvent event,
  ) async* {
    if (event is LoadingSimilarProducts) {
      yield* loadSimilarProduct(event);
    }
  }

  Stream<SimilarProductsState> loadSimilarProduct(
      LoadingSimilarProducts event) async* {
    yield SimilarProductsLoading();

    try {
      SearchResult similarProductSearchResult =
          await searchApi.getSimilarProduct(event.type, event.subType);
      SearchResult comboProductSearchResult =
          await searchApi.getComboProduct(event.type, event.subType);
      var similarSearchResult = getSimilarProductData(similarProductSearchResult);
      var comboSearchResult = getComboProductData(comboProductSearchResult);
      yield SimilarProductsLoadingSuccessful(
          similarSearchResult, comboSearchResult);
    } catch (e) {
      print(e.toString());
      yield SimilarProductsLoadingFailure();
    }
  }

  List<Product> getSimilarProductData(SearchResult searchResult) {
    final hits = searchResult.hits;

    int len = hits.length;
    List<Product> result = List();
    for (int x = 0; x < len; x++) {
      Doc hit = hits[x];

      List<String> imgUrls = List();
      try {
        for (var img in hit.doc['images']) {
          imgUrls.add(img.toString());
        }
      } catch (e) {
        LOG.e("Unable to get images for ${hit.doc}", e);
      }

      List<String> colors = List();
      try {
        for (var col in hit.doc['colour']) {
          colors.add(col['hexCode'].toString());
        }
      } catch (e) {
        LOG.e("Unable to get hexcode for ${hit.doc}", e);
      }

      Set<String> tags = HashSet();
      try {
        for (var tag in hit.doc['tags']) {
          tags.add(tag.toString());
        }
      } catch (e) {
        LOG.e("Unable to get tags for ${hit.doc}", e);
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
          isCombo: hit.doc["isCombo"],
          type: hit.doc['type'],
          isAvailable: hit.doc['isAvailable'],
          subType: hit.doc['subType']);
      result.add(prod);
    }
    List<Product> finalResult = List();
    finalResult.addAll(result);

    return finalResult;
  }

  List<ComboProduct> getComboProductData(SearchResult searchResult) {
    final hits = searchResult.hits;
    int len = hits.length;

    List<ComboProduct> result = List();
    for (int x = 0; x < len; x++) {
      Doc hit = hits[x];

      List<String> imgUrls = List();
      for (var img in hit.doc['images']) {
        imgUrls.add(img.toString());
      }

      List<String> descriptions = List();
      for (var desc in hit.doc['description']) {
        descriptions.add(desc.toString());
      }

      var prod = ComboProduct(
        title: hit.doc['name'],
        imageUrls: imgUrls,
        descriptions: descriptions,
        discountPrice: hit.doc['discountPrice'],
        retailPrice: hit.doc['sellingPrice'],
        productId: hit.doc['productID'],
        isAvailable: hit.doc['isAvailable'],
      );
      result.add(prod);
    }
    List<ComboProduct> finalResult = List();
    finalResult.addAll(result);

    return finalResult;
  }
}
