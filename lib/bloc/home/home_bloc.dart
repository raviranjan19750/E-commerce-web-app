import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:elastic_client/elastic_client.dart';
import 'package:equatable/equatable.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/models/product.dart';
import 'package:living_desire/service/searchapi.dart';

import '../../logger.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  var LOG = LogBuilder.getLogger();

  HomeBloc() : super(HomeInitial());
  var filter = "";
  SearchApi searchApi = SearchApi();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if (event is ViewAll) {
      // yield* _viewAll(event);
    } else if (event is InitializeHome) {
      // make call to cloud function get tag name and product list
      yield* _initialiseHome();
    }
  }

  Stream<HomeState> _initialiseHome() async* {
    yield LoadingHomeProducts();
    try {
      List<String> filteredText = [
        "Bean Bags",
        "Blue Bean Bags",
        "Red Bean Bags",
        "yellow Bean Bags",
        "green Bean Bags",
      ];

      Map<String, List<Product>> res = {};

      for (var itm in filteredText) {
        SearchResult result =
            await searchApi.getFilteredProduct(itm, offset: 0, limit: 15);
        res[itm] = _createDataFromSearch(result);
        print(res[itm]);
      }

      // List<FilterTag> tags = await searchApi.getAllCategoryTags();
      // print("ALL CATAGORIES : ");
      // for (var tag in tags) {
      //   print(tag.description.toString());
      // }
      /* List<FilterTag> tags = await searchApi.getAllCategoryTags();
      print("ALL CATAGORIES : ");
      for (var tag in tags) {
        print(tag.description.toString());
      }*/
      yield SuccessfulLoadingHomeProducts(res);
    } catch (e) {
      print(e.toString());
    }
  }

  List<Product> _createDataFromSearch(SearchResult searchResult,
      {int offset = 0, int limit = 20}) {
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
          isCombo: hit.doc['isCombo'],
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
