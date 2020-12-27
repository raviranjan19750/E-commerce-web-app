enum FilterSortCriteria {
  RELEVANCE,
  PRICE_LOW_TO_HIGH,
  PRICE_HIGH_TO_LOW,
  NEWEST_FIRST
}

class Sorting {
  static List<Map<String, dynamic>> getCriteria(FilterSortCriteria criteria) {
    switch (criteria) {
      case FilterSortCriteria.RELEVANCE:
        return [
        ];
      case FilterSortCriteria.PRICE_LOW_TO_HIGH:
        return [
          {
            "discountPrice": {
              "order": "asc"
            }
          }
        ];
      case FilterSortCriteria.PRICE_HIGH_TO_LOW:
        return [
          {
            "discountPrice": {
              "order": "desc"
            }
          }
        ];
      case FilterSortCriteria.NEWEST_FIRST:
        return [
          {
            "addedDate": {
              "order": "desc"
            }
          }
        ];
      default:
        return List.empty();
    }
  }
}
