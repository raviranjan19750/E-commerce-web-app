part of 'similar_products_bloc.dart';

@immutable
abstract class SimilarProductsEvent {}



class LoadingSimilarProducts extends SimilarProductsEvent{

  final String type;
  final String subType;

  LoadingSimilarProducts(this.type, this.subType);


}


