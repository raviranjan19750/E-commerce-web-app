class FilterTag {
  final String tag;
  final String description;
  List<FilterCategoryChild> _filterChilds = List();

  List<FilterCategoryChild> get filterChilds => _filterChilds;

  FilterTag(this.tag, {this.description});

  void addChild(FilterCategoryChild child) {
    _filterChilds.add(child);
  }

  void removeChild(FilterCategoryChild child) {
    _filterChilds.remove(child);
  }

  void reset() {
    _filterChilds = List();
  }
}

class FilterCategoryChild {
  final String filterID;
  final String description;
  final bool selected;

  FilterCategoryChild(this.filterID, this.description, this.selected);
}