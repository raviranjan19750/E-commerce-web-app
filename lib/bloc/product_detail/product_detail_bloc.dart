import 'dart:async';
import 'dart:collection';

import 'package:bloc/bloc.dart';
import 'package:elastic_client/elastic_client.dart';
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
    }
  }

  Stream<ProductDetailState> loadProductDetail(LoadProductDetail event) async* {
    yield ProductDetailLoading();
    try {
      var productDescription =
          await productRepository.getProductVariantDescription(
              productID: event.productID, variantID: event.variantID);
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
      var comboProductDescription = await productRepository
          .getComboProductDescription(productID: event.productID);
      yield ComboProductDetailLoadingSuccessful(comboProductDescription);
    } catch (e) {
      print(e.toString());
      yield ProductDetailLoadingFailure();
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
        LOG.e("Unable to get color for ${hit.doc}", e);
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
