part of 'app_bar_bloc.dart';

abstract class AppBarState extends Equatable {
  const AppBarState();
  
  @override
  List<Object> get props => [];
}

class AppBarInitial extends AppBarState {}
