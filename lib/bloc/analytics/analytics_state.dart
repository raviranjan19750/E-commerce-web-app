part of 'analytics_bloc.dart';

abstract class AnalyticsState extends Equatable {
  const AnalyticsState();
  
  @override
  List<Object> get props => [];
}

class AnalyticsInitial extends AnalyticsState {}
