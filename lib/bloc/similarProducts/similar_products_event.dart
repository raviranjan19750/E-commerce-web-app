part of 'similar_products_bloc.dart';

@immutable
abstract class SimilarProductsEvent {}



class LoadingSimilarProducts extends SimilarProductsEvent{

  final List<String> type;
  final List<String> subType;

  LoadingSimilarProducts(this.type, this.subType);


}


