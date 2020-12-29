import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/service/searchapi.dart';
import 'package:meta/meta.dart';

part 'similar_products_event.dart';
part 'similar_products_state.dart';

class SimilarProductsBloc extends Bloc<SimilarProductsEvent, SimilarProductsState> {

  SimilarProductsBloc({this.searchApi}) : super(SimilarProductsInitial());


  final SearchApi searchApi;



  @override
  Stream<SimilarProductsState> mapEventToState(
    SimilarProductsEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is LoadingSimilarProducts) {
      yield* loadSimilarProduct(event);
    }

  }


  Stream<SimilarProductsState> loadSimilarProduct (LoadingSimilarProducts event) async* {

    yield SimilarProductsLoading();

    try{

      SearchResult searchResult = await searchApi.getSimilarProduct(event.type, event.subType);
      var similarSearchResult = getSimilarProductData(searchResult);
      yield SimilarProductsLoadingSuccessful(similarSearchResult);

    }
    catch(e) {
      print(e.toString());
      yield SimilarProductsLoadingFailure();
    }

  }

  List<Product> getSimilarProductData(SearchResult searchResult) {

    final hits = searchResult.hits;


    int len = hits.length;
    print(len);

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
          subType: hit.doc['subType']);
      result.add(prod);
    }
    List<Product> finalResult = List();
    finalResult.addAll(result);

    return finalResult;


  }

}
