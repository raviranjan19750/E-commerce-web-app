import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/models/filtertags.dart';
import 'package:living_desire/models/product.dart';
// import 'package:living_desire/models/models.dart';

class SearchApi {
  // curl -XGET "http://es01:9200/catalogue/_search" -H 'Content-Type: application/json' -d'{  "query": {    "query_string": {      "default_field": "description",      "query": "A*"    }  },  "aggs": {    "auto_complete": {      "terms": {        "field": "description.keyword",        "size": 10      }    }  }}'
  final String SEARCH_URL =
      "https://1c52378e333549089895e04eccedf28c.us-central1.gcp.cloud.es.io:9243";

  static const String INDEX_NAME = "products-dev";

  Client client;

  SearchApi() {
    // var uri = Uri.parse(SEARCH_URL);
    final transport = HttpTransport(
        url: SEARCH_URL,
        authorization: 'Basic ZWxhc3RpYzplMnB3aDdnN29SSm5MZ2NxYUxGRE1nUnI=');
    // authorization: 'Basic ZWxhc3RpYzpjckFaZnRBWjVhZDU2UE1Ja1oyZm9qelU=');
    client = Client(transport);
  }

  Future<SearchResult> getFilteredProduct(String title,
      {int limit, int offset}) async {
    if (title.isEmpty) {
      final searchResult =
          await client.search(index: INDEX_NAME, limit: limit, offset: offset);
      return searchResult;
    }

    final Map<String, dynamic> query = Map();

    // query.putIfAbsent("size", () => 30);
    Map<String, dynamic> matches = Map();
    matches.putIfAbsent("name", () => title);

    query.putIfAbsent("match", () => matches);
    final searchResult = await client.search(
        index: INDEX_NAME, query: query, limit: limit, offset: offset);
    return searchResult;
  }

  Future<List<FilterTag>> getAllCategoryTags() async {
    final Map<String, dynamic> aggregation = Map();

    final Map<String, dynamic> sizeAggregation = Map();
    sizeAggregation.putIfAbsent("terms", () => _getTerms("size"));
    aggregation.putIfAbsent("size-aggr", () => sizeAggregation);

    final Map<String, dynamic> colorAggregation = Map();
    colorAggregation.putIfAbsent("terms", () => _getTerms("colour.name"));
    aggregation.putIfAbsent("color-aggr", () => colorAggregation);

    final Map<String, dynamic> tagAggregation = Map();
    tagAggregation.putIfAbsent("terms", () => _getTerms("tags"));
    aggregation.putIfAbsent("tags-aggr", () => tagAggregation);

    final Map<String, dynamic> typeAggregation = Map();
    typeAggregation.putIfAbsent("terms", () => _getTerms("type"));
    aggregation.putIfAbsent("type-aggr", () => typeAggregation);

    final Map<String, dynamic> sybTypeAggregation = Map();
    sybTypeAggregation.putIfAbsent("terms", () => _getTerms("subType"));
    aggregation.putIfAbsent("subType-aggr", () => sybTypeAggregation);

    final searchResult = await client.search(
        index: INDEX_NAME, limit: 0, aggregations: aggregation);
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

    final tagResult = searchResult.aggregations['tags-aggr'];
    FilterTag tagsTag = FilterTag("TAGS", description: "Tags");
    tagResult.buckets.forEach((element) {
      tagsTag.addChild(FilterCategoryChild(
          element.key.toString(),
          element.key.toString() + " (" + element.docCount.toString() + ")",
          false));
    });
    tag.add(tagsTag);

    final typeResult = searchResult.aggregations['type-aggr'];
    FilterTag typeTag = FilterTag("TYPE", description: "Type");
    typeResult.buckets.forEach((element) {
      typeTag.addChild(FilterCategoryChild(
          element.key.toString(),
          element.key.toString() + " (" + element.docCount.toString() + ")",
          false));
    });
    tag.add(typeTag);

    final subTypeResult = searchResult.aggregations['subType-aggr'];
    FilterTag subTypeTag = FilterTag("SUB-TYPE", description: "Sub Type");
    subTypeResult.buckets.forEach((element) {
      subTypeTag.addChild(FilterCategoryChild(
          element.key.toString(),
          element.key.toString() + " (" + element.docCount.toString() + ")",
          false));
    });
    tag.add(subTypeTag);

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
