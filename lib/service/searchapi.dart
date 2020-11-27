import 'dart:ui';
import 'dart:collection';
import 'dart:convert' as convert;
import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/models/models.dart';

import 'CustomHttpsTransport.dart';

class SearchApi {
  // curl -XGET "http://es01:9200/catalogue/_search" -H 'Content-Type: application/json' -d'{  "query": {    "query_string": {      "default_field": "description",      "query": "A*"    }  },  "aggs": {    "auto_complete": {      "terms": {        "field": "description.keyword",        "size": 10      }    }  }}'
  final String SEARCH_URL = "http://localhost:9200";

  Client client;

  SearchApi() {
    // var uri = Uri.parse(SEARCH_URL);
    final transport = HttpTransport(url: SEARCH_URL);
    client = Client(transport);
  }

  // Future<List<String>> getSuggestion(String keyword) async {
  //   final Map<String, dynamic> query = Map();
  //   Map<String, dynamic> query_string = Map();
  //   query_string.putIfAbsent("fields", () => ["description", "category"]);
  //   query_string.putIfAbsent("query", () => keyword + "*");
  //   query.putIfAbsent("query_string", () => query_string);
  //
  //
  //   final Map<String, dynamic> aggregation = HashMap();
  //   Map<String, dynamic> terms = HashMap();
  //   terms.putIfAbsent("field", () => "description.keyword");
  //   terms.putIfAbsent("size", () => 10);
  //   Map<String, dynamic> ac = HashMap();
  //   ac.putIfAbsent("terms", () => terms);
  //   aggregation.putIfAbsent("auto_complete", () => ac);
  //
  //   final searchResult = await client.search(index: "catalogue",  query: query, aggregations: aggregation);
  //
  //   var autocomplete_result = searchResult.aggregations["auto_complete"].buckets;
  //   // print(autocomplete_result);
  //   List<String> result = List();
  //   for (var b in autocomplete_result) {
  //     result.add(b.key.toString());
  //   }
  //   return result;
  // }

  Future<List<Product>> getFilteredProduct(String title) async {
    final Map<String, dynamic> query = Map();

    Map<String, dynamic> matches = Map();
    matches.putIfAbsent("title", () => title);

    query.putIfAbsent("match", () => matches);
    final searchResult = await client.search(index: "product", query: query);
    final hits = searchResult.hits;
    List<Product> result = List();
    for (var hit in hits) {
      Product tmpProduxt = Product(
        title: hit.doc['title'],
        color: hit.doc['color'],
        imageUrl: hit.doc['imageUrl'],
        size: hit.doc['size'],
        discountPrice: hit.doc['offerPrice'],
        retailPrice: hit.doc['retailPrice'],
      );
      result.add(tmpProduxt);
    }
    return result;
  }

  Future<List<Product>> getAllProducts() async {
    final searchResult = await client.search(index: "product");
    final hits = searchResult.hits;
    List<Product> result = List();
    for (var hit in hits) {
      Product tmpProduxt = Product(
        title: hit.doc['title'],
        color: hit.doc['color'],
        imageUrl: hit.doc['imageUrl'],
        size: hit.doc['size'],
        discountPrice: hit.doc['offerPrice'],
        retailPrice: hit.doc['retailPrice'],
      );
      result.add(tmpProduxt);
    }
    return result;
  }

  Future<List<FilterTag>> getAllCategoryTags() async {
    final Map<String, dynamic> aggregation = Map();

    final Map<String, dynamic> sizeAggregation = Map();
    sizeAggregation.putIfAbsent("terms", () => _getTerms("size"));
    aggregation.putIfAbsent("size-aggr", () => sizeAggregation);

    final Map<String, dynamic> colorAggregation = Map();
    colorAggregation.putIfAbsent("terms", () => _getTerms("color"));
    aggregation.putIfAbsent("color-aggr", () => colorAggregation);

    final searchResult = await client.search(
        index: "product", limit: 0, aggregations: aggregation);
    List<FilterTag> tag = List();
    final sizeresult = searchResult.aggregations['size-aggr'];
    FilterTag sizetag = FilterTag("SIZE", description: "Size");
    sizeresult.buckets.forEach((element) {
      sizetag.addChild(FilterCategoryChild(
          element.key.toString(),
          element.key.toString() + " (" + element.docCount.toString() + ")",
          false));
    });
    tag.add(sizetag);
    final colorresult = searchResult.aggregations['color-aggr'];
    FilterTag colortag = FilterTag("COLOR", description: "Color");
    colorresult.buckets.forEach((element) {
      colortag.addChild(FilterCategoryChild(
          element.key.toString(),
          element.key.toString() + " (" + element.docCount.toString() + ")",
          false));
    });
    tag.add(colortag);
    return tag;
  }

  Map<String, dynamic> _getTerms(String fieldName, {size = 100}) {
    final Map<String, dynamic> terms = Map();
    terms.putIfAbsent("field", () => fieldName);
    terms.putIfAbsent("size", () => size);
    Map<String, dynamic> order = Map();
    order.putIfAbsent("_count", () => "desc");

    terms.putIfAbsent("order", () => order);

    return terms;
  }
}

// void main() async {
//   SearchApi api = SearchApi();
//   api.getAllProducts();
// }
