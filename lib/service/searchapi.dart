import 'package:elastic_client/elastic_client.dart';
import 'package:living_desire/logger.dart';
import 'package:living_desire/models/filtertags.dart';

class SearchApi {
  var LOG = LogBuilder.getLogger();

  final String SEARCH_URL =
      "https://1c52378e333549089895e04eccedf28c.us-central1.gcp.cloud.es.io:9243";

  static const String INDEX_NAME = "products-dev";

  Client client;

  SearchApi() {
    final transport = HttpTransport(
        url: SEARCH_URL,
        authorization: 'Basic ZWxhc3RpYzplMnB3aDdnN29SSm5MZ2NxYUxGRE1nUnI=');
    client = Client(transport);
  }

  Future<SearchResult> getFilteredProduct(String title,
      {int limit,
      int offset,
      List<Map<String, dynamic>> filter,
      List<Map<String, dynamic>> sort}) async {
    final Map<String, dynamic> query = Map();

    final Map<String, dynamic> queryCriteria = Map();
    if (title != null && title.isNotEmpty) {
      var tmp = [
        {
          "match": {"name": title}
        }
      ];
      queryCriteria.putIfAbsent("must", () => tmp);
    }

    if (filter != null && filter.isNotEmpty) {
      queryCriteria.putIfAbsent("filter", () => filter);
    }

    query.putIfAbsent("bool", () => queryCriteria);
    LOG.i(query);
    final searchResult = await client.search(
        index: INDEX_NAME,
        query: query,
        limit: limit,
        offset: offset,
        sort: sort);
    print(searchResult);
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
    FilterTag sizetag = FilterTag("SIZE", "size", description: "Size");
    sizeresult.buckets.forEach((element) {
      sizetag.addChild(FilterCategoryChild(
          element.key.toString(), element.key.toString(), false));
    });
    tag.add(sizetag);

    final colorresult = searchResult.aggregations['color-aggr'];
    FilterTag colortag =
        FilterTag("COLOR", "colour.name", description: "Color");
    colorresult.buckets.forEach((element) {
      colortag.addChild(FilterCategoryChild(
          element.key.toString(), element.key.toString(), false));
    });
    tag.add(colortag);

    final tagResult = searchResult.aggregations['tags-aggr'];
    FilterTag tagsTag = FilterTag("TAGS", "tags", description: "Tags");
    tagResult.buckets.forEach((element) {
      tagsTag.addChild(FilterCategoryChild(
          element.key.toString(), element.key.toString(), false));
    });
    tag.add(tagsTag);

    final typeResult = searchResult.aggregations['type-aggr'];
    FilterTag typeTag = FilterTag("TYPE", "type", description: "Type");
    typeResult.buckets.forEach((element) {
      typeTag.addChild(FilterCategoryChild(
          element.key.toString(), element.key.toString(), false));
    });
    tag.add(typeTag);

    final subTypeResult = searchResult.aggregations['subType-aggr'];
    FilterTag subTypeTag =
        FilterTag("SUB-TYPE", "subType", description: "Sub Type");
    subTypeResult.buckets.forEach((element) {
      subTypeTag.addChild(FilterCategoryChild(
          element.key.toString(), element.key.toString(), false));
    });
    tag.add(subTypeTag);

    return tag;
  }

  Future<List<FilterTag>> getSubTypes(String type) async {
    final Map<String, dynamic> query = Map();

    Map<String, dynamic> matches = Map();
    matches.putIfAbsent("type", () => type);

    query.putIfAbsent("match", () => matches);

    final Map<String, dynamic> aggregation = Map();

    final Map<String, dynamic> sybTypeAggregation = Map();
    sybTypeAggregation.putIfAbsent("terms", () => _getTerms("subType"));
    aggregation.putIfAbsent("subType-aggr", () => sybTypeAggregation);

    final searchResult = await client.search(
        index: INDEX_NAME, limit: 1, query: query, aggregations: aggregation);
    List<FilterTag> tag = List();

    String imageUrl = searchResult.hits.elementAt(0).doc['images'][0];

    final subTypeResult = searchResult.aggregations['subType-aggr'];
    FilterTag subTypeTag =
        FilterTag("SUB-TYPE", "subType", description: "Sub Type");
    subTypeResult.buckets.forEach((element) {
      subTypeTag.addChild(
          FilterCategoryChild(element.key.toString(), imageUrl, false));
    });
    tag.add(subTypeTag);

    return tag;
  }

  Future<List<FilterTag>> getProductType() async {
    final Map<String, dynamic> aggregation = Map();

    final Map<String, dynamic> typeAggregation = Map();
    typeAggregation.putIfAbsent("terms", () => _getTerms("type"));
    aggregation.putIfAbsent("type-aggr", () => typeAggregation);

    final searchResult = await client.search(
        index: INDEX_NAME, limit: 0, aggregations: aggregation);
    List<FilterTag> tag = List();

    final typeResult = searchResult.aggregations['type-aggr'];
    FilterTag typeTag = FilterTag("TYPE", "type", description: "Type");
    typeResult.buckets.forEach((element) {
      typeTag.addChild(FilterCategoryChild(
          element.key.toString(),
          element.key.toString() + " (" + element.docCount.toString() + ")",
          false));
    });
    tag.add(typeTag);
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

  Future<SearchResult> getSimilarProduct(String type, String subType) async {


    var criteria = {
      "bool": {
        "filter": [
          {
            "terms": {
              "type": [type]
            }
          },
          {
            "terms": {
              "subType": [subType]
            }
          }
        ]
      }
    };
    final searchResult = await client.search(index: INDEX_NAME, limit: 18, query: criteria);

    return searchResult;
  }
}
