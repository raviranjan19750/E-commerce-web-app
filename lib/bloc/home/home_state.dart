part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class LoadingHomeProducts extends HomeState {}

class SuccessfulLoadingHomeProducts extends HomeState {
  // final Map<String, List<Product>> productList;
  final List<List<Product>> productList;
  SuccessfulLoadingHomeProducts(this.productList);
}

class FailedLoadingHomeProducts extends HomeState {}
