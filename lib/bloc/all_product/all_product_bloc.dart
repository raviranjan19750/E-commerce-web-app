import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/models/models.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../logger.dart';

part 'all_product_event.dart';
part 'all_product_state.dart';

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {

  var LOG = LogBuilder.getLogger();

  final SearchApi searchApi;
  var filter = "";

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
          offset: offset, limit: limit);
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
              : "";
      filter = filteredText;
      SearchResult result = await searchApi.getFilteredProduct(filteredText,
          offset: 0, limit: 20);
      yield _createDataFromSearch(result);
    } catch (e) {
      print(e);
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
        subType: hit.doc['subType']
      );
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
