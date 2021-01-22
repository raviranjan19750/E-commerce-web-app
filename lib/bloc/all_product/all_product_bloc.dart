import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/models/sorting_criteria.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../logger.dart';

part 'all_product_event.dart';

part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  var LOG = LogBuilder.getLogger();

  final SearchApi searchApi;
  var filter = "";
  List<Map<String, dynamic>> filterCriteria;
  FilterSortCriteria sortCriteria = FilterSortCriteria.RELEVANCE;

  @override
  Stream<Transition<AllProductEvent, AllProductState>> transformEvents(
      Stream<AllProductEvent> events,
      TransitionFunction<AllProductEvent, AllProductState> transitionFn) {
    return events
        .debounceTime(const Duration(milliseconds: 350))
        .switchMap(transitionFn);
  }

  AllProductBloc({@required this.searchApi})
      : assert(searchApi != null),
        super(AllProductInitial());

  @override
  Stream<AllProductState> mapEventToState(
    AllProductEvent event,
  ) async* {
    if (event is InitializeLoadingProduct) {
      yield* _mapLoadingFilteredProduct(LoadAllProductWithSearchParams());
    } else if (event is LoadAllProductWithSearchParams) {
      yield* _mapLoadingFilteredProduct(event);
    } else if (event is LoadNextProduct) {
      yield* _mapLoadNextProduct(state, event);
    }
  }

  Stream<AllProductState> _mapLoadNextProduct(
      AllProductState state, LoadNextProduct event) async* {
    if (state is SuccessLoadingAllProduct && !state.isEndReached) {
      yield LoadingNextProduct();
      final List<Product> previousList = state.productList;
      int limit = state.limit;
      int offset = state.offset + limit;
      SearchResult result = await searchApi.getFilteredProduct(filter,
          offset: offset, limit: limit, filter: filterCriteria);
      SuccessLoadingAllProduct res = _createDataFromSearch(result,
          prev: previousList, limit: limit, offset: offset);
      yield res;
    }
  }

  Stream<AllProductState> _mapLoadingFilteredProduct(
      LoadAllProductWithSearchParams event) async* {
    yield LoadingAllProduct();
    try {
      // searchApi
      String filteredText =
          (event.filterText != null && event.filterText.isNotEmpty)
              ? event.filterText
              : filter;
      filter = filteredText;
      filterCriteria = event.filters != null ? event.filters : filterCriteria;
      sortCriteria = event.sort != null ? event.sort : sortCriteria;
      SearchResult result = await searchApi.getFilteredProduct(filter,
          offset: 0,
          limit: 20,
          filter: filterCriteria,
          sort: Sorting.getCriteria(sortCriteria));
      yield _createDataFromSearch(result);
    } catch (exception, stackTrace) {
      await Sentry.captureException(exception, stackTrace: stackTrace);
      yield FailureLoadingProduct();
    }
  }

  SuccessLoadingAllProduct _createDataFromSearch(SearchResult searchResult,
      {List<Product> prev, int offset = 0, int limit = 20}) {
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
        LOG.e('Unable to get color for ${hit.doc}');
      }

      Set<String> tags = HashSet();
      try {
        for (var tag in hit.doc['tags']) {
          tags.add(tag.toString());
        }
      } catch (e) {
        LOG.e('Unable to get tags for ${hit.doc}');
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
    if (prev != null) finalResult.addAll(prev);
    finalResult.addAll(result);
    bool isEndReached = searchResult.totalCount <= finalResult.length;
    return SuccessLoadingAllProduct(finalResult,
        offset: offset,
        limit: limit,
        totalResults: searchResult.totalCount,
        isEndReached: isEndReached);
    ;
  }
}
